import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Services/auth.dart';
import 'package:my_app/Services/dataStore.dart';
import 'package:my_app/UI/Screens/managementApp.dart';
import '../../BLoC/loginEvent.dart';

class LogIn extends StatefulWidget {
  final _bloc;
  final _mBloc;
  AuthService service;
  LogIn(this._bloc, this._mBloc, this.service);
  @override
  State<StatefulWidget> createState() =>
      LogInState(this._bloc, this._mBloc, this.service);
}

class LogInState extends State<LogIn> {
  // final _formKey = GlobalKey<FormState>();
  String _last2Digits = "";
  final _bloc;
  final _mBloc;
  TextEditingController numberController = new TextEditingController();
  TextEditingController dialogText = new TextEditingController();
  FocusNode _focusNode = new FocusNode();
  AuthService service;
  LogInState(this._bloc, this._mBloc, this.service);

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:
          // Form(
          //   key: _formKey,
          //   child:
          Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/green.jpeg'),
                    repeat: ImageRepeat.repeat,
                    fit: BoxFit.fill,
                  ),
                ),
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Ametta Place",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    )),
              ),
              StreamBuilder(
                stream: _bloc.showLogIn,
                initialData: false,
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  return Container(
                    height: MediaQuery.of(context).size.height / 4,
                    color: Colors.white,
                    child: Stack(
                      children: <Widget>[
                        if (snapshot.data)
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: ButtonTheme(
                              minWidth: MediaQuery.of(context).size.width - 100,
                              height: 50,
                              child: StreamBuilder(
                                stream: _bloc.changLast2,
                                initialData: "",
                                builder: (BuildContext context,
                                    AsyncSnapshot<String> snapshot2) {
                                  return StreamBuilder(
                                    stream: _bloc.logOTP,
                                    initialData: false,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<bool> snapshot3) {
                                      return RaisedButton(
                                          child: Text(
                                            "Sign In",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          color: Colors.green,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          onPressed: () {
                                            _last2Digits = snapshot2.data;
                                            var number = numberController.text;
                                            // .replaceFirst("0", "+63");
                                            print(number);
                                            // loginUser(number, context);
                                            service.signInNumber(
                                              _bloc,
                                              number,
                                              "Enter OTP sent to **** *** **" +
                                                  _last2Digits,
                                              numberController,
                                            );
                                          });
                                    },
                                  );
                                },
                              ),
                            ),
                          )
                      ],
                    ),
                  );
                },
              ),
              Container(
                height: MediaQuery.of(context).size.height / 4,
                color: Colors.white,
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 150,
                        child: Text(
                          "Need help? Check out FAQ or Contact admin",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              width: MediaQuery.of(context).size.width - 100,
              height: (MediaQuery.of(context).size.height / 2) - 100,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Text(
                      "Welcome to Ametta Place Community App!",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none),
                    ),
                  ),
                  StreamBuilder(
                    stream: _bloc.changeInfo,
                    initialData: "Sign in using your registered mobile number",
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      return Container(
                          margin: EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 10),
                          child: Text(
                            snapshot.data,
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none),
                          ));
                    },
                  ),
                  StreamBuilder(
                    stream: _bloc.changeNumber,
                    initialData: 11,
                    builder:
                        (BuildContext context, AsyncSnapshot<int> snapshot) {
                      return Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        width: MediaQuery.of(context).size.width - 200,
                        child: StreamBuilder(
                          stream: _bloc.changeVerificationId,
                          initialData: "",
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot2) {
                            return TextFormField(
                              focusNode: _focusNode,
                              autofocus: true,
                              decoration: InputDecoration(
                                counterText: "",
                              ),
                              maxLength: snapshot.data,
                              controller: numberController,
                              validator: (String value) {
                                if (value.isEmpty)
                                  return "Number is not registered in admin";

                                return null;
                              },
                              keyboardType: TextInputType.phone,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                letterSpacing: 5,
                              ),
                              onChanged: (value) async {
                                if (snapshot.data == 11 && value.length == 11) {
                                  _bloc.logInEventSink.add(DisplayLogIn());
                                  _bloc.logInEventSink.add(
                                    ChangeLast2(
                                      value.substring(value.length - 2),
                                    ),
                                  );
                                } else if (snapshot.data == 6 &&
                                    value.length == 6) {
                                  // _bloc.logInEventSink.add(LogInside());
                                  // ManagementDataStore.getGuestList(_mBloc);
                                  // AuthCredential credential =
                                  //     PhoneAuthProvider.getCredential(
                                  //   verificationId: snapshot2.data,
                                  //   smsCode: dialogText.text,
                                  // );

                                  // AuthResult result = await _auth
                                  //     .signInWithCredential(credential);

                                  // FirebaseUser user = result.user;

                                  // if (user != null) {
                                  //   ManagementDataStore.getGuestList(_mBloc);
                                  _bloc.logInEventSink.add(LogInside());
                                  //   // Navigator.push(
                                  //   //   context,
                                  //   //   MaterialPageRoute(
                                  //   //     builder: (context) => ManagementApp(),
                                  //   //   ),
                                  //   // );
                                  // } else {
                                  //   print("Error");
                                  // }
                                }
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      // ),
    );

    // Scaffold(
    //   appBar: AppBar(
    //     flexibleSpace: LogInAppBar(),
    //   ),
    // );
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
