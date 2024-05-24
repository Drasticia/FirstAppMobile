import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNav extends StatelessWidget {
  void Function(int)? onTabChange;
  BottomNav({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical:15, horizontal: 2),
      child: GNav(
        color: Colors.black,
        activeColor: Color.fromARGB(255, 159, 19, 19),
        tabActiveBorder: Border.all(color: Colors.white),
        tabBackgroundColor: Colors.grey.shade100,
        tabBorderRadius: 30,
        mainAxisAlignment: MainAxisAlignment.center,
        onTabChange: (value) => onTabChange!(value),
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Home',
            padding: EdgeInsetsDirectional.symmetric(vertical: 25, horizontal: 20),
            iconSize: 20,
          ),
          GButton(
            icon: Icons.event_note,
            text: 'Disaster',
            padding: EdgeInsetsDirectional.symmetric(vertical: 25, horizontal: 20),
            iconSize: 20,
          ),
          GButton(
            icon: Icons.track_changes,
            text: 'Report',
            padding: EdgeInsetsDirectional.symmetric(vertical: 25, horizontal: 20),
            iconSize: 20,
            
          ),
          GButton(
            icon: Icons.import_contacts,
            text: 'Mitigation',
            padding: EdgeInsetsDirectional.symmetric(vertical: 25, horizontal: 20),
            iconSize: 20,
          ),
          GButton(
            icon: Icons.more_vert,
            
          ),
        ],
      ),
    );
  }
}