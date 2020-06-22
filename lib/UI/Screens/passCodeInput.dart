import 'package:flutter/material.dart';

class PassCodeInput extends StatefulWidget {
  final int digitLength;
  PassCodeInput({this.digitLength});
  @override
  State<StatefulWidget> createState() => PassCodeInputState(digitLength);
}

class PassCodeInputState extends State<PassCodeInput> {
  final int _digitLength;
  List<TextEditingController> _controllers = new List();
  List<Widget> _inputFields = new List();
  List<FocusNode> _focusNodes = new List();
  var _enables = [];

  PassCodeInputState(this._digitLength) {
    for (int i = 0; i < _digitLength; i++) {
      _enables.add(false);
      _focusNodes.add(FocusNode());
      _controllers.add(
        new TextEditingController(text: "0"),
      );

      if (i == 0) {
        _controllers.elementAt(i).clear();
        // _enables[i] = true;
      }

      _inputFields.add(
        TextField(
          controller: _controllers[i],
          maxLength: 1,
          focusNode: _focusNodes[i],
          autofocus: i == 0 ? true : false,
          keyboardType: TextInputType.number,
          // enabled: _enables[i],
          decoration: InputDecoration(
            counterText: "",
          ),
          onChanged: (value) {
            if (value.isNotEmpty) {
              if (i < (_digitLength - 1)) {
                // _controllers.elementAt(i + 1).clear();
                _focusNodes.elementAt(i).unfocus();
                // _enables[i] = false;
                // _enables[i + 1] = true;
                _focusNodes.elementAt(i + 1).requestFocus();
                _controllers[i + 1].selection = TextSelection(
                  baseOffset: 0,
                  extentOffset: 1,
                );
              }
            } else {
              if (i > 0) {
                _controllers[i].text = "0";
                // _controllers.elementAt(i - 1).clear();
                _focusNodes.elementAt(i).unfocus();
                _focusNodes.elementAt(i - 1).requestFocus();
                _controllers[i - 1].selection = TextSelection(
                  baseOffset: 0,
                  extentOffset: 1,
                );
              }
            }
          },
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          for (int i = 0; i < _inputFields.length; i++)
            Expanded(
              child: _inputFields[i],
            )
        ],
      ),
    );
  }
}
