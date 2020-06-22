import 'package:flutter/material.dart';
import '../../BLoC/managementAppEvent.dart';

class Bottom extends StatelessWidget {
  final _bloc;
  final _view;
  Bottom(this._bloc, this._view);

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              color: _view == "home" ? Colors.black : Colors.grey,
              onPressed: () =>
                  _bloc.managementAppEventSink.add(DisplayView("home")),
            ),
            Text("Home"),
          ],
        ),
        Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.update),
              color: _view == "update" ? Colors.black : Colors.grey,
              onPressed: () =>
                  _bloc.managementAppEventSink.add(DisplayView("updates")),
            ),
            Text("Updates"),
          ],
        ),
        Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              color: _view == "settings" ? Colors.black : Colors.grey,
              onPressed: () =>
                  _bloc.managementAppEventSink.add(DisplayView("settings")),
            ),
            Text("Settings"),
          ],
        ),
      ],
    );
  }
}
