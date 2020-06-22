import 'package:flutter/material.dart';
import 'package:my_app/Data/guest.dart';
import 'package:my_app/Services/dataStore.dart';
import 'package:intl/intl.dart';
import '../../BLoC/managementAppEvent.dart';

class GuestList extends StatefulWidget {
  final bloc;
  // final guestList;
  final isNotificationDisplayed;
  // final guests;
  // final deliveries;
  GuestList({
    this.isNotificationDisplayed,
    this.bloc,
    // this.guests, this.deliveries
  });

  @override
  State<StatefulWidget> createState() => GuestListState(
        isNotificationDisplayed: isNotificationDisplayed,
        bloc: bloc,
        // guests: guests,
        // deliveries: deliveries,
      );
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class GuestListState extends State<GuestList> {
  final bloc;
  // final guestList;
  var isNotificationDisplayed;
  var guests;
  var deliveries;
  List<TextEditingController> _guestControllers = new List();
  List<TextEditingController> _deliveriesControllers = new List();

  GuestListState({
    this.isNotificationDisplayed,
    this.bloc,
    // this.guests,
    // this.deliveries,
  }) {
    // print(this.guestList);
    // bloc.getGuestList.listen((data) {
    //   guests = List<Guest>.from(data.where((guest) => guest.type == "guest"));

    //   deliveries =
    //       List<Guest>.from(data.where((guest) => guest.type == "guest"));
    // });
  }

  Widget build(BuildContext context) {
    bloc.getGuestList.listen((data) {
      if (mounted) {
        setState(() {
          guests = List<Guest>.from(
              data.where((guest) => guest.type == "guestVisitor"));

          deliveries = List<Guest>.from(
              data.where((guest) => guest.type != "guestVisitor"));

          if (guests != null) {
            for (int i = 0; i < guests.length; i++) {
              _guestControllers.add(
                new TextEditingController(text: guests[i].name),
              );
            }
          }

          if (deliveries != null) {
            for (int i = 0; i < deliveries.length; i++) {
              _deliveriesControllers.add(
                new TextEditingController(text: deliveries[i].name),
              );
            }
          }
        });
      }
    });

    return Column(
      // mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (isNotificationDisplayed)
          TextFormField(
            focusNode: AlwaysDisabledFocusNode(),
            readOnly: true,
            decoration: InputDecoration(
              fillColor: Colors.yellow,
              filled: true,
              labelText: "Guest Added!",
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              prefixIcon: Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              suffixIcon: Container(
                padding: EdgeInsets.all(10),
                child: ButtonTheme(
                  minWidth: 25.0,
                  height: 25.0,
                  buttonColor: Colors.yellow,
                  child: FlatButton(
                    child: Text("Dismiss"),
                    onPressed: () {
                      isNotificationDisplayed = false;
                      bloc.managementAppEventSink
                          .add(DisplayNotification(false));
                    },
                  ),
                ),
              ),
            ),
          ),
        // if (guestList.isNotEmpty)
        Container(
          height: MediaQuery.of(context).size.height - 220,
          child: ListView(
            children: <Widget>[
              if (guests != null && guests.length != 0)
                Row(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: Text(
                        guests.isNotEmpty ? "Guest(s)" : "",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              if (guests != null && guests.length != 0)
                for (int i = 0; i < guests.length; i++)
                  Container(
                    margin: const EdgeInsets.only(
                      bottom: 10,
                      left: 10,
                      right: 10,
                    ),
                    child: Material(
                      elevation: 10,
                      shadowColor: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                      child: TextFormField(
                        controller: _guestControllers[i],
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        focusNode: AlwaysDisabledFocusNode(),
                        readOnly: true,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            // borderSide: BorderSide(style: BorderStyle.solid),
                          ),
                          labelText: DateFormat('MM/dd/yyyy')
                              .format(guests[i].dateTimeVisit),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                          suffixIcon: guests[i].status == "approved"
                              ? PopupMenuButton(
                                  itemBuilder: (context) {
                                    List<PopupMenuItem<String>> items =
                                        List<PopupMenuItem<String>>();
                                    items.add(
                                      PopupMenuItem<String>(
                                        key: Key("1"),
                                        value: "settings",
                                        child: Text("Settings"),
                                      ),
                                    );

                                    return items;
                                  },
                                )
                              : Container(
                                  padding: EdgeInsets.all(10),
                                  child: ButtonTheme(
                                    minWidth: 25.0,
                                    height: 25.0,
                                    buttonColor: Colors.yellow,
                                    child: RaisedButton(
                                      child: Text("Approve"),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      onPressed: () {
                                        ManagementDataStore.approveGuest(
                                            bloc: bloc,
                                            path: guests[i].documentId);
                                      },
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
              if (deliveries != null && deliveries.length != 0)
                Row(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: Text(
                        deliveries.isNotEmpty ? "Deliveries" : "",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              if (deliveries != null && deliveries.length != 0)
                for (int i = 0; i < deliveries.length; i++)
                  Container(
                    margin: const EdgeInsets.only(
                      bottom: 10,
                      left: 10,
                      right: 10,
                    ),
                    child: Material(
                      elevation: 10,
                      shadowColor: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                      child: TextFormField(
                        controller: _deliveriesControllers[i],
                        focusNode: AlwaysDisabledFocusNode(),
                        readOnly: true,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            // borderSide: BorderSide(style: BorderStyle.solid),
                          ),
                          labelText: DateFormat('MM/dd/yyyy')
                              .format(deliveries[i].dateTimeVisit),
                          prefixIcon: Icon(
                            deliveries[i].type == 2
                                ? Icons.motorcycle
                                : Icons.directions_bus,
                            color: Colors.black,
                          ),
                          suffixIcon: deliveries[i].status == "approved"
                              ? PopupMenuButton(
                                  itemBuilder: (context) {
                                    List<PopupMenuItem<String>> items =
                                        List<PopupMenuItem<String>>();
                                    items.add(
                                      PopupMenuItem<String>(
                                        key: Key("1"),
                                        value: "settings",
                                        child: Text("Settings"),
                                      ),
                                    );

                                    return items;
                                  },
                                )
                              : Container(
                                  padding: EdgeInsets.all(10),
                                  child: ButtonTheme(
                                    minWidth: 25.0,
                                    height: 25.0,
                                    buttonColor: Colors.yellow,
                                    child: RaisedButton(
                                      child: Text("Approve"),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      onPressed: () {
                                        ManagementDataStore.approveGuest(
                                            bloc: bloc,
                                            path: guests[i].documentId);
                                      },
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
            ],
          ),
        ),
        if ((guests != null && guests.length == 0) &&
            (deliveries != null && deliveries.length == 0))
          Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(20.0),
                child: Text(
                  "You have no expected delivery/guests",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(
                Icons.calendar_today,
                size: 40,
                color: Colors.black54,
              ),
            ],
          )
      ],
    );
  }

  @override
  void dispose() {
    _guestControllers.forEach((element) {
      element.dispose();
    });
    _deliveriesControllers.forEach((element) {
      element.dispose();
    });
    super.dispose();
  }
}
