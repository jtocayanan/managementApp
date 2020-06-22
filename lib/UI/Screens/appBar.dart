import 'package:flutter/material.dart';
import 'package:my_app/Data/guest.dart';
import 'package:my_app/Services/dataStore.dart';
import '../../BLoC/managementAppEvent.dart';

class NavBar extends StatelessWidget {
  final _bloc;
  final _view;
  final bool isSaveEnabled;
  final _service;
  NavBar(this._bloc, this._view, this.isSaveEnabled, this._service);

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: 120.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/green.jpeg'),
            repeat: ImageRepeat.repeat,
            fit: BoxFit.fill,
          ),
        ),
        child: Row(
          // textDirection: TextDirection.rtl,
          children: <Widget>[
            if (_view == "home")
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Text(
                  "Hi Tristan!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              )
            else
              Container(
                margin: EdgeInsets.only(left: 20),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () =>
                      _bloc.managementAppEventSink.add(DisplayView("home")),
                ),
              ),
            Spacer(),
            if (_view == "home")
              Container(
                margin: const EdgeInsets.all(20.0),
                child: Text(
                  "Ametta Place",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              )
            else
              StreamBuilder(
                stream: _bloc.addGuest,
                initialData: Guest(),
                builder: (BuildContext context, AsyncSnapshot<Guest> snapshot) {
                  return Container(
                    margin: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                      onTap: () {
                        if (isSaveEnabled) {
                          ManagementDataStore.addGuest(
                            bloc: _bloc,
                            name: snapshot.data.name,
                            purpose: snapshot.data.purpose,
                            plateNumber: snapshot.data.plateNumber,
                            guestType: snapshot.data.type,
                            userId: _service.getCurrentUserId(),
                          );
                          _bloc.managementAppEventSink
                              .add(DisplayNotification(true));
                          _bloc.managementAppEventSink.add(DisplayView("home"));
                        }
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(
                          color: isSaveEnabled ? Colors.white : Colors.white60,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
