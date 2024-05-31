
import 'package:apptubes/screen/mitigationScreens.dart';
import 'package:flutter/material.dart';
import 'package:apptubes/components/bottom_navbar.dart';
import 'package:apptubes/screen/disasterscreen.dart';
import 'package:apptubes/screen/homescreen.dart';
import 'package:apptubes/screen/reportscreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    HomeScreen(),
    DisasterScreen(),
    const ReportScreen(),
    MitigationPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromRGBO(255, 192, 65, 0.612), Color.fromRGBO(249, 61, 61, 0.612)],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: _pages[_selectedIndex],
            ),
            BottomNav(
              onTabChange: (index) => navigateBottomBar(index),
            ),
          ],
        ),
      ),
    );
  }
}