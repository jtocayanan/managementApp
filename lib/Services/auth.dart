import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_app/BLoC/loginEvent.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var _user;

  Future signInNumber(
      bloc, String phoneNumber, String otpMessage, controller) async {
    // phoneNumber = '+16505554567';
    // String smsCode = '123456';

    validatePhoneNumber(phoneNumber).then(
      (result) {
        if (result.body.isNotEmpty) {
          _user = json.decode(result.body);
          bloc.logInEventSink.add(ChangeNumberSize());
          bloc.logInEventSink.add(LogOTP());
          bloc.logInEventSink.add(
            ChangeInformationText(otpMessage),
          );
          controller.clear();

          // _auth.verifyPhoneNumber(
          //   phoneNumber: phoneNumber,
          //   timeout: Duration(seconds: 60),
          //   verificationCompleted: (AuthCredential credential) async {
          //     AuthResult result = await _auth.signInWithCredential(credential);
          //     FirebaseUser user = result.user;

          //     if (user != null) {
          //       bloc.logInEventSink.add(ChangeNumberSize());
          //       bloc.logInEventSink.add(LogOTP());
          //       bloc.logInEventSink.add(
          //         ChangeInformationText(otpMessage),
          //       );
          //       controller.clear();
          //     } else {
          //       print("Error");
          //     }
          //   },
          //   verificationFailed: (AuthException exception) {
          //     print(exception.message);
          //   },
          //   codeSent: (String verificationId, [int forceResendingToken]) {
          //     // bloc.changLast2.listen((last2) {
          //     //   bloc.logInEventSink.add(
          //     //     ChangeInformationText(
          //     //       "Enter OTP sent to **** *** **" + last2,
          //     //       // "Enter OTP sent to **** *** ****",
          //     //     ),
          //     //   );
          //     // });
          //     // numberController.clear();
          //     // bloc.logInEventSink.add(ChangeVerificationId(verificationId));
          //     // print(verificationId);
          //   },
          //   codeAutoRetrievalTimeout: null,
          // );
        }
      },
    );
  }

  Future<http.Response> validatePhoneNumber(phoneNumber) {
    return http.get(
        'http://10.0.2.2:5001/managementapp-773c2/us-central1/app/validateNumber?phoneNumber=' +
            phoneNumber);
  }

  String getCurrentUserId() {
    return _user["uid"];
  }
}
