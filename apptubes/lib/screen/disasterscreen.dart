import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DisasterScreen extends StatefulWidget {
  @override
  _DisasterScreenState createState() => _DisasterScreenState();
}

class _DisasterScreenState extends State<DisasterScreen> {
  String? selectedType;
  String? selectedTime;
  String? selectedCriticality;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text(
          'Disaster',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    Text(
                      'History',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Report')
                      .where('status', isEqualTo: 'accepted')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    final data = snapshot.requireData;
                    return ListView.builder(
                      itemCount: data.size,
                      itemBuilder: (context, index) {
                        var report = data.docs[index];
                        return disasterCard(
                          report['emergency'],
                          report['address'],
                          report['timestamp'] != null
                              ? (report['timestamp'] as Timestamp).toDate().toString()
                              : 'Unknown time',
                          report['detailedInformation'],
                          context,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget disasterCard(String type, String location, String time, String criticality, BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: getDisasterIcon(type),
        title: Text(type),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Location: $location'),
            Text('Time: $time'),
            Text('Criticality: $criticality'),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return DraggableScrollableSheet(
                  expand: false,
                  builder: (BuildContext context, ScrollController scrollController) {
                    return SingleChildScrollView(
                      controller: scrollController,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  Container(
                                    child: getDisasterIcon(type),
                                    width: 100,
                                    height: 5,
                                    margin: EdgeInsets.only(bottom: 20),
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(2.5),
                                    ),
                                  ),
                                  Text(
                                    'Disaster Information',
                                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    type,
                                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    criticality,
                                    style: TextStyle(fontSize: 18, color: Colors.blue),
                                  ),
                                  Text(
                                    time,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Location: $location',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(height: 20),
                            Image.network(
                              'https://maps.googleapis.com/maps/api/staticmap?center=$location&zoom=13&size=600x300&key=AIzaSyA-iLkgb1HiZwOepOWO9TtTI0Ly99SiH0A',
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
          child: Text('Detail'),
        ),
      ),
    );
  }

  Widget getDisasterIcon(String type) {
    switch (type) {
      case 'Earthquake':
        return Icon(Icons.terrain, color: Colors.red);
      case 'Flood':
        return Icon(Icons.water_damage, color: Colors.blue);
      case 'Typhoon':
        return Icon(Icons.toys, color: Colors.green);
      case 'Fire':
        return Icon(Icons.local_fire_department, color: Colors.orange);
      case 'Volcano':
        return Icon(Icons.landscape, color: Colors.brown);
      default:
        return Icon(Icons.error, color: Colors.grey);
    }
  }
}
