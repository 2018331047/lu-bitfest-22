import 'package:flutter/material.dart';

import '../../widgets/appbar.dart';
import 'busSchedule.dart';
import 'request.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final List<Widget> pages = [
    BusSchedule(),
    Request(),
  ];

  int selectPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      selectPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: APPBAR(selectPageIndex),
        backgroundColor: Colors.white,
      ),
      body: pages[selectPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.black54,
        selectedItemColor: Colors.black,
        currentIndex: selectPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Bus Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Request',
          ),
        ],
      ),
    );
  }
}
