import 'package:flutter/material.dart';
import '../../BLoC/managementAppEvent.dart';

class Menu {
  int id;
  String code;
  String value;
  Menu({int id, String code, String value}) {
    this.id = id;
    this.code = code;
    this.value = value;
  }
}

class FloatingMenu extends StatelessWidget {
  final _bloc;
  FloatingMenu(this._bloc);

  final menuList = [
    new Menu(
      id: 1,
      code: "guestVisitor",
      value: "Guest/Visitor",
    ),
    new Menu(
      id: 2,
      code: "homeServices",
      value: "Home Services",
    ),
    new Menu(
      id: 3,
      code: "foodDelivery",
      value: "Food Delivery",
    ),
    new Menu(
      id: 4,
      code: "applicationFurniture",
      value: "Application/Furniture Delivery",
    ),
  ];
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(20),
      ),
      child: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Color(0xAA00BB10),
        shape: CircleBorder(),
        onPressed: null,
      ),
      itemBuilder: (BuildContext context) {
        List<PopupMenuItem<String>> items = List<PopupMenuItem<String>>();
        print(menuList.length);
        for (int i = 0; i < menuList.length; i++) {
          items.add(
            PopupMenuItem<String>(
              key: Key(menuList[i].id.toString()),
              value: menuList[i].code,
              child: Text(menuList[i].value),
            ),
          );
        }

        return items;
      },
      onSelected: (selected) =>
          _bloc.managementAppEventSink.add(DisplayView(selected)),
    );
  }
}
