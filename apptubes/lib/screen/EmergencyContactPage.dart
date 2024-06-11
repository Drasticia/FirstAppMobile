import 'package:flutter/material.dart';

class EmergencyContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Contact',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Emergency Contact',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 182, 182, 182),
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'General',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.local_police),
                          title: Text('Police Station'),
                          trailing: Icon(Icons.call),
                        ),
                        ListTile(
                          leading: Icon(Icons.local_fire_department),
                          title: Text('Fire Station'),
                          trailing: Icon(Icons.call),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Keluarga',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.local_police),
                        title: Text('Police Station'),
                        trailing: Icon(Icons.call),
                      ),
                      ListTile(
                        leading: Icon(Icons.local_fire_department),
                        title: Text('Fire Station'),
                        trailing: Icon(Icons.call),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
