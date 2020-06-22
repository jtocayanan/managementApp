import 'package:flutter/material.dart';

class LogInAppBar extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/green.jpeg'),
          repeat: ImageRepeat.repeat,
          fit: BoxFit.fill,
        ),
      ),
      child: Row(
        children: <Widget>[
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
        ],
      ),
    );
  }
}
