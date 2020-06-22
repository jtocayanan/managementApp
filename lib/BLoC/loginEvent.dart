abstract class LoginEvent {
  var data;
}

class DisplayLogIn extends LoginEvent {}

class ChangeInformationText extends LoginEvent {
  final String data;
  ChangeInformationText(this.data);
}

class ChangeNumberSize extends LoginEvent {}

class ChangeLast2 extends LoginEvent {
  final String data;
  ChangeLast2(this.data);
}

class LogInside extends LoginEvent {}

class LogOTP extends LoginEvent {}

class ChangeVerificationId extends LoginEvent {
  final String data;
  ChangeVerificationId(this.data);
}
