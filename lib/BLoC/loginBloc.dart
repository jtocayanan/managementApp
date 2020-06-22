import 'dart:async';
import './loginEvent.dart';

class LogInBloc {
  bool _showLogIn = false;
  String _infoText = "Sign in using your registered mobile number";
  int _numberSize = 8;
  String _last2 = "";
  bool _logIn = false;
  bool _logOTP = false;
  String _verificationId = "";

  final _showLogInStateController = StreamController<bool>();
  StreamSink<bool> get _inShowLogIn => _showLogInStateController.sink;
  Stream<bool> get showLogIn => _showLogInStateController.stream;

  final _changeInformationTextStateController = StreamController<String>();
  StreamSink<String> get _inChangeInfo =>
      _changeInformationTextStateController.sink;
  Stream<String> get changeInfo => _changeInformationTextStateController.stream;

  final _changeLast2StateController = StreamController<String>();
  StreamSink<String> get _inChangeLast2 => _changeLast2StateController.sink;
  Stream<String> get changLast2 => _changeLast2StateController.stream;

  final _changeNumberSizeStateController = StreamController<int>();
  StreamSink<int> get _inChangeNumber => _changeNumberSizeStateController.sink;
  Stream<int> get changeNumber => _changeNumberSizeStateController.stream;

  final _logInStateController = StreamController<bool>();
  StreamSink<bool> get _inLogIn => _logInStateController.sink;
  Stream<bool> get logIn => _logInStateController.stream;

  final _logOTPStateController = StreamController<bool>();
  StreamSink<bool> get _inLogOTP => _logOTPStateController.sink;
  Stream<bool> get logOTP => _logOTPStateController.stream;

  final _changeVerificationIdStateController = StreamController<String>();
  StreamSink<String> get _inChangeVerificationId =>
      _changeVerificationIdStateController.sink;
  Stream<String> get changeVerificationId =>
      _changeVerificationIdStateController.stream;

  final _logInEventController = StreamController<LoginEvent>();
  Sink<LoginEvent> get logInEventSink => _logInEventController.sink;

  LogInBloc() {
    _logInEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(LoginEvent event) {
    if (event is DisplayLogIn) {
      _showLogIn = true;
      _inShowLogIn.add(_showLogIn);
    } else if (event is ChangeInformationText) {
      _infoText = event.data;
      _inChangeInfo.add(_infoText);
    } else if (event is ChangeLast2) {
      _last2 = event.data;
      _inChangeLast2.add(_last2);
    } else if (event is LogInside) {
      _logIn = true;
      _inLogIn.add(_logIn);
    } else if (event is LogOTP) {
      _logOTP = true;
      _inLogOTP.add(_logOTP);
    } else if (event is ChangeVerificationId) {
      _verificationId = event.data;
      _inChangeVerificationId.add(_verificationId);
    } else {
      _numberSize = 6;
      _inChangeNumber.add(_numberSize);
    }
  }

  void dispose() {
    _showLogInStateController.close();
    _changeInformationTextStateController.close();
    _changeNumberSizeStateController.close();
    _changeLast2StateController.close();
    _logInStateController.close();
    _logOTPStateController.close();
    _changeVerificationIdStateController.close();
    _logInEventController.close();
  }
}
