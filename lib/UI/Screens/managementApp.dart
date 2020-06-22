import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Services/auth.dart';
import './appBar.dart';
import './bottomBar.dart';
import './mainBody.dart';
import './floatingMenu.dart';
import '../../BLoC/managementAppBloc.dart';
import '../../Data/guest.dart';
import '../../BLoC/managementAppEvent.dart';
import '../../Services/dataStore.dart';

class ManagementApp extends StatefulWidget {
  final _service;
  ManagementApp(this._service);

  @override
  State<StatefulWidget> createState() => ManagementAppState(_service);
}

class ManagementAppState extends State<ManagementApp> {
  // var _bloc = ManagementAppBloc();
  AuthService _service;
  ManagementAppState(this._service) {}

  var _managementAppBloc = ManagementAppBloc();
  // ManagementAppState();

  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _managementAppBloc.displayView,
      initialData: "home",
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            flexibleSpace: StreamBuilder(
              stream: _managementAppBloc.enableSave,
              initialData: false,
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot2) {
                return NavBar(
                  _managementAppBloc,
                  snapshot.data,
                  snapshot2.data,
                  _service,
                );
              },
            ),
          ),
          body: MainBody(
            view: snapshot.data,
            bloc: _managementAppBloc,
            service: _service,
          ),
          floatingActionButton:
              snapshot.data == "home" ? FloatingMenu(_managementAppBloc) : null,
          bottomNavigationBar: Bottom(_managementAppBloc, snapshot.data),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _managementAppBloc.dispose();
  }
}
