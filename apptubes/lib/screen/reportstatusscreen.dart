import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReporterStatusScreen extends StatefulWidget {
  @override
  _ReporterStatusScreenState createState() => _ReporterStatusScreenState();
}

class _ReporterStatusScreenState extends State<ReporterStatusScreen> {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 192, 65, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 192, 65, 1),
        automaticallyImplyLeading: true,
        title: Text(
          'My Reports',
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Report')
            .where('email', isEqualTo: user?.email)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            child: ListView(
              children: snapshot.data!.docs.map((doc) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    title: Text(
                      doc['emergency'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Detail: ${doc['detailedInformation']}'),
                        Text('Status: ${doc['status']}'),
                      ],
                    ),
                    onTap: () => _showReportDetails(doc),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }

  void _showReportDetails(DocumentSnapshot doc) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          doc['emergency'],
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${doc['name']}'),
            Text('Phone: ${doc['phonenumber']}'),
            Text('Details: ${doc['detailedInformation']}'),
            Text('Location: ${doc['address']}'),
            Text('Status: ${doc['status']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 188, 45, 34),
              foregroundColor: Color.fromARGB(255, 255, 255, 255),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}
