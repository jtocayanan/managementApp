import 'package:flutter/material.dart';
import 'package:my_app/Services/auth.dart';
import './Screens/managementApp.dart';
import './Screens/login.dart';
import '../BLoC/loginBloc.dart';
import '../BLoC/managementAppBloc.dart';

// bool _isLogInValid = false;

class MainModule extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainModuleState();
}

class MainModuleState extends State<MainModule> {
  var _loginBloc = LogInBloc();
  var _managementBloc = ManagementAppBloc();
  var _service = AuthService();

  MainModuleState();

  Widget build(BuildContext context) {
    return MaterialApp(
      home:
          // ManagementApp()

          StreamBuilder(
        stream: _loginBloc.logIn,
        initialData: false,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return snapshot.data
              ? ManagementApp(_service)
              : LogIn(_loginBloc, _managementBloc, _service);
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _loginBloc.dispose();
  }
}
