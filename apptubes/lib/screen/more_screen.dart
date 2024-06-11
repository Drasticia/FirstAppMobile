import 'dart:async';
import 'package:apptubes/screen/reportstatusscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _userEmail;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
      setState(() {
        _userEmail = user.email;
      });
    } else {
      setState(() {
        _userEmail = 'User not logged in';
      });
    }
  }

  Future<void> _editEmail() async {
    TextEditingController emailController = TextEditingController(text: _userEmail);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Email'),
          content: TextField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: 'Enter your new email',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                User? user = _firebaseAuth.currentUser;
                if (user != null) {
                  await user.updateEmail(emailController.text);
                  setState(() {
                    _userEmail = emailController.text;
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
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
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 80,
            child: Icon(
              Icons.person,
              color: Colors.black,
              size: 150,
            ),
          ),
          SizedBox(height: 10),
          ListTile(
            leading: Icon(
              Icons.email,
              size: 30,
              color: Colors.black,
            ),
            title: Text(
              _userEmail ?? 'Loading...',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            trailing: TextButton(
              onPressed: _editEmail,
              child: Text(
                'Edit',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          Container(
            width: 1,
            height: 1,
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(2.5),
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
          Container(
            width: 1,
            height: 1,
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(2.5),
            ),
          ),
          Spacer(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log Out'),
            onTap: _signOut,
          ),
        ],
      ),
    );
  }

  void _signOut() async {
    await _firebaseAuth.signOut();
    Navigator.pop(context);
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Notice',
        message: 'Anda sudah berhasil log-out',
        contentType: ContentType.failure,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
