import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RecentInformationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recent Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.all(16.0),
              child: Container(
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10.0,
                      spreadRadius: 5.0,
                      offset: Offset(-1.0, 1.0),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bencana Baru Terjadi',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Report')
                          .where('status', isEqualTo: 'accepted')
                          .orderBy('timestamp', descending: true)
                          .limit(1)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Center(child: Text('No reports available'));
                        }
                        var report = snapshot.data!.docs.first;
                        var data = report.data() as Map<String, dynamic>;
                        var timestamp = (data['timestamp'] as Timestamp).toDate();
                        var location = data['address'];

                        String mapUrl = 'https://maps.googleapis.com/maps/api/staticmap?center=$location&zoom=13&size=600x300&key=AIzaSyA-iLkgb1HiZwOepOWO9TtTI0Ly99SiH0A';

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                mapUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 25.0),
                            Row(
                              children: [
                                Image.asset(
                                  'lib/icons/locationIcon.png',
                                  width: 25,
                                  height: 25,
                                  color: Colors.blue,
                                ),
                                SizedBox(width: 8.0),
                                Expanded(
                                  child: Text(
                                    location,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              children: [
                                Icon(Icons.crisis_alert, color: Colors.red),
                                SizedBox(width: 8.0),
                                Expanded(
                                  child: Text(
                                    'Disaster Type: ${data['emergency']}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              children: [
                                Image.asset(
                                  'lib/icons/warningIcon.png',
                                  width: 25,
                                  height: 25,
                                  color: Colors.orange,
                                ),
                                SizedBox(width: 8.0),
                                Expanded(
                                  child: Text(
                                    'Criticality: ${data['detailedInformation']}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              children: [
                                Image.asset(
                                  'lib/icons/timeIcon.png',
                                  width: 25,
                                  height: 25,
                                  color: Colors.lightGreen,
                                ),
                                SizedBox(width: 8.0),
                                Expanded(
                                  child: Text(
                                    'Waktu: $timestamp',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
