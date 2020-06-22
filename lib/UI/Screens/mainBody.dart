import 'package:flutter/material.dart';
import './home.dart';
import './registerGuest.dart';

class MainBody extends StatelessWidget {
  final bloc;
  final view;
  final service;
  // final isNotificationDisplayed;
  MainBody({this.view, this.bloc, this.service});

  Widget build(BuildContext context) {
    Widget selected;
    if (view == "home") {
      return HomeView(bloc, service);
    } else if (view == "guestVisitor") {
      return RegisterGuestView(bloc, view);
    } else if (view == "homeServices") {
      return RegisterGuestView(bloc, view);
    } else if (view == "foodDelivery") {
      return RegisterGuestView(bloc, view);
    } else if (view == "applicationFurniture") {
      return RegisterGuestView(bloc, view);
    }

    return selected;
  }
}
