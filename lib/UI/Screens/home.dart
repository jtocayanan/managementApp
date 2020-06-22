import 'package:flutter/material.dart';
import 'package:my_app/Services/dataStore.dart';
import './guestList.dart';
import '../../Data/guest.dart';
import '../../BLoC/managementAppBloc.dart';

class HomeView extends StatefulWidget {
  // final isNotificationDisplayed;
  final _bloc;
  final _service;
  HomeView(this._bloc, this._service);
  @override
  State<StatefulWidget> createState() => HomeViewState(_bloc, _service);
}

class HomeViewState extends State<HomeView> {
  ManagementAppBloc _bloc;
  // final guestList;
  // bool isNotificationDisplayed;
  var forApproval;
  var guests;
  var deliveries;
  var _service;
  HomeViewState(this._bloc, this._service) {
    ManagementDataStore.getGuestList(_bloc, _service.getCurrentUserId());

    _bloc.getGuestList.listen((data) {
      if (mounted) {
        setState(() {
          forApproval = List<Guest>.from(
              data.where((guest) => guest.status == "pending"));

          // guests = List<Guest>.from(
          //     data.where((guest) => guest.type == "guestVisitor"));

          // deliveries = List<Guest>.from(
          //     data.where((guest) => guest.type == "guestVisitor"));
        });
      }
    });
  }

  Widget build(BuildContext context) {
    return Container(
        color: Color(0xFFFFFFFF),
        child: StreamBuilder(
          stream: _bloc.displayNotification,
          initialData: false,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            return Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    if ((forApproval != null && forApproval.length > 0) &&
                        snapshot.data == false)
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: Icon(Icons.notifications_active),
                      ),
                    if ((forApproval != null && forApproval.length > 0) &&
                        snapshot.data == false)
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: Text(
                          "${forApproval.length} New Alerts",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    Spacer(),
                    if (snapshot.data == false)
                      Container(
                        margin: const EdgeInsets.all(20.0),
                        child: Text(
                          "History",
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: Color(0xAA009A00),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                  ],
                ),
                GuestList(
                  isNotificationDisplayed: snapshot.data,
                  bloc: _bloc,
                  // guests: guests,
                  // deliveries: deliveries,
                ),
              ],
            );
          },
        ));
  }
}
