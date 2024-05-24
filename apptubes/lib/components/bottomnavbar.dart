import 'package:flutter/material.dart';

import '../screen/disasterscreen.dart';
import '../screen/homescreen.dart';
import '../screen/mitigationScreens.dart';
import '../screen/reportscreen.dart';

class BottomNavBar2 extends StatefulWidget {
  int selectedIndex = 0;

  @override
  State<BottomNavBar2> createState() => _BottomNavBar2State();
}

class _BottomNavBar2State extends State<BottomNavBar2> {
  @override
  void initState() {
    super.initState();
  }

  int currentTab = 0;
  final List<Widget> pages = [
    HomeScreen(),
    const DisasterScreen(),
    const ReportScreen(),
    const MitigationPage(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(255, 192, 65, 0.612),
              Color.fromRGBO(249, 61, 61, 0.612)
            ],
          ),
        ),
        child: PageStorage(bucket: bucket, child: currentScreen),
      ),
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.track_changes,
            color: Color.fromARGB(255, 188, 45, 34),
          ),
          onPressed: () {
            setState(() {
              currentScreen = ReportScreen();
              currentTab = 4;
            });
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        color: Color.fromRGBO(249, 61, 61, 0.612),
        elevation: 0,
        child: Container(
          height: 60,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = HomeScreen();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: currentTab == 0
                              ? const Color.fromARGB(255, 124, 9, 9)
                              : Colors.white,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                            color: currentTab == 0
                                ? const Color.fromARGB(255, 124, 9, 9)
                                : Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = DisasterScreen();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.event_note,
                          color: currentTab == 1
                              ? const Color.fromARGB(255, 124, 9, 9)
                              : Colors.white,
                        ),
                        Text(
                          'Disaster',
                          style: TextStyle(
                            color: currentTab == 1
                                ? const Color.fromARGB(255, 124, 9, 9)
                                : Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = MitigationPage();
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.import_contacts,
                          color: currentTab == 2
                              ? const Color.fromARGB(255, 124, 9, 9)
                              : Colors.white,
                        ),
                        Text(
                          'Mitigation',
                          style: TextStyle(
                            color: currentTab == 2
                                ? const Color.fromARGB(255, 124, 9, 9)
                                : Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = DisasterScreen();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.more_vert,
                          color: currentTab == 3
                              ? const Color.fromARGB(255, 124, 9, 9)
                              : Colors.white,
                        ),
                        Text(
                          'More',
                          style: TextStyle(
                            color: currentTab == 3
                                ? const Color.fromARGB(255, 124, 9, 9)
                                : Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
