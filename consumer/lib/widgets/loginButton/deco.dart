import 'package:flutter/material.dart';

import 'buttonText.dart';

class Deco extends StatelessWidget {
  final String text;
  Deco(this.text);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        alignment: Alignment.center,
        height: 40.0,
        width: 160,
        decoration: BoxDecoration(
          color: Colors.blue[400],
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: ButtonText(text),
      ),
    );
  }
}
