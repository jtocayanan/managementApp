import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/Data/guest.dart';
import '../BLoC/managementAppEvent.dart';

class ManagementDataStore {
  static getGuestList(bloc, userId) async {
    final firestoreInstance = Firestore.instance;
    firestoreInstance.collection("GuestList").getDocuments().then((value) {
      List<Guest> _guestList = List();
      value.documents
          .where((element) => element.data["userId"] == userId)
          .forEach((element) {
        _guestList.add(Guest(
            name: element.data["name"],
            type: element.data["type"],
            status: element.data["status"],
            plateNumber: element.data["plateNumber"],
            dateTimeVisit: DateTime.parse(
                element.data["dateTimeVisit"].toDate().toString()),
            purpose: element.data["purpose"],
            documentId: element.documentID));
      });
      bloc.managementAppEventSink.add(GetGuestList(_guestList));
    });
  }

  static addGuest({bloc, name, purpose, plateNumber, guestType, userId}) async {
    final firestoreInstance = Firestore.instance;
    firestoreInstance.collection("GuestList").document().setData({
      "name": name,
      "purpose": purpose,
      "plateNumber": plateNumber,
      "status": "approved",
      "guest": guestType,
      "dateTimeVisit": DateTime.now(),
      "userId": userId
    }).then((_) {
      print("success!");
    });
  }

  static approveGuest({bloc, path}) async {
    final firestoreInstance = Firestore.instance;
    firestoreInstance
        .collection("GuestList")
        .document(path)
        .updateData({"status": "approved"}).then((_) {
      print("success!");
    });
  }
}
