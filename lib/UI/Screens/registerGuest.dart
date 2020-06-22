import 'package:flutter/material.dart';
import 'package:my_app/Data/guest.dart';
import '../../BLoC/managementAppEvent.dart';

class RegisterNotification extends Notification {
  final bool isRequiredFilled;

  const RegisterNotification({this.isRequiredFilled});
}

class RegisterGuestView extends StatefulWidget {
  final _bloc;
  final _type;
  RegisterGuestView(this._bloc, this._type);
  @override
  State<StatefulWidget> createState() => RegisterGuestViewState(_bloc, _type);
}

class RegisterGuestViewState extends State<RegisterGuestView> {
  var _nameController = TextEditingController();
  var _purposeController = TextEditingController();
  var _plateNumberController = TextEditingController();
  final _bloc;
  final _formKey = GlobalKey<FormState>();
  Guest guest;
  RegisterGuestViewState(this._bloc, var type) {
    guest = Guest(type: type);
  }

  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Name is required";
                        }

                        return null;
                      },
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: "Name, Surname",
                        prefixIcon: Icon(Icons.person),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _nameController.clear();
                          },
                        ),
                      ),
                      onChanged: (name) {
                        guest.name = name;
                        _bloc.managementAppEventSink.add(AddGuest(guest));
                        _bloc.managementAppEventSink
                            .add(EnableSave(name.isNotEmpty));
                      }),
                )
              ],
            ),
            Row(
              children: <Widget>[
                // Container(
                //   margin: const EdgeInsets.all(20.0),
                //   child: Text(
                //     "?",
                //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                //   ),
                // ),
                Expanded(
                  child: TextFormField(
                    controller: _purposeController,
                    decoration: InputDecoration(
                      labelText: "Purpose of visit (optional)",
                      prefixIcon: Text(""),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _purposeController.clear();
                        },
                      ),
                    ),
                    onChanged: (purpose) {
                      guest.purpose = purpose;
                      _bloc.managementAppEventSink.add(AddGuest(guest));
                    },
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                // Container(
                //   margin: const EdgeInsets.all(20.0),
                //   child: Icon(Icons.directions_car),
                // ),
                Expanded(
                  child: TextFormField(
                    controller: _plateNumberController,
                    decoration: InputDecoration(
                      labelText: "Plate number (optional)",
                      prefixIcon: Icon(Icons.directions_car),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _plateNumberController.clear();
                        },
                      ),
                    ),
                    onChanged: (plateNumber) {
                      guest.plateNumber = plateNumber;
                      _bloc.managementAppEventSink.add(AddGuest(guest));
                    },
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  margin: const EdgeInsets.only(
                      top: 20, bottom: 20, left: 20, right: 20),
                  child: Text(
                      "Guest is required to present driver's license at the gate "),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
