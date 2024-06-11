import 'dart:async';

import 'package:apptubes/screen/reportstatusscreen.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

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
        )
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(
              Icons.track_changes,
              size: 30,
              color: Colors.black,
            ),
            title: Text(
              'Report Status',
              style: TextStyle(
                fontSize: 16
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
            onTap: () { _signOut();
              // Perform logout
            },
          ),
        ],
      ),
    );
  }
  void _signOut() async{
      await _firebaseAuth.signOut();
      Navigator.pop(context);
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Notice',
          message:
          'Anda sudah berhasil log-out',
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
  }
}