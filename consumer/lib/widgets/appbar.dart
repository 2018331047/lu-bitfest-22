import 'package:flutter/material.dart';

class APPBAR extends StatelessWidget {
  final int index;
  const APPBAR(this.index);
  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      return const Text(
        'Bus Schedule',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
      );
    }
    ;
    if (index == 1) {
      return const Text(
        'Request For Seat',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
      );
    } else {
      return const Text(
        'Alerts',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
      );
    }
  }
}
