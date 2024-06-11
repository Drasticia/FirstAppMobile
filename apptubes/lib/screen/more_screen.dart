import 'package:apptubes/screen/reportstatusscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  String? _userEmail;

  @override
  void initState() {
    super.initState();
    _getUserEmail();
  }

  Future<void> _getUserEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _userEmail = user.email;
      });
    } else {
      setState(() {
        _userEmail = 'User not logged in';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text(
          'More',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(
              Icons.person,
              size: 30,
              color: Colors.black,
            ),
            title: Text(
              _userEmail ?? 'Loading...',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.track_changes,
              size: 30,
              color: Colors.black,
            ),
            title: Text(
              'Report Status',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            onTap: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => ReporterStatusScreen())
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log Out'),
            onTap: () {
              // Perform logout
            },
          ),
        ],
      ),
    );
  }
}
