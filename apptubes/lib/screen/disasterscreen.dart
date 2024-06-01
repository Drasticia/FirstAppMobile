import 'package:flutter/material.dart';

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
                child: ListView(
                  children: [
                    disasterCard('Earthquake', 'Cianjur, Jawa Barat', '17:08, 30 February 2024', 'Mild (5.3 SR)', context),
                    disasterCard('Flood', 'Rancaekek, Bandung', '02:00, 20 September 2023', 'Mild (5.3 SR)', context),
                    disasterCard('Typhoon', 'Cianjur, Jawa Barat', '17:08, 30 February 2024', 'Mild (5.3 SR)', context),
                    disasterCard('Fire', 'Cianjur, Jawa Barat', '17:08, 30 February 2024', 'Mild (5.3 SR)', context),
                    disasterCard('Volcano', 'Cianjur, Jawa Barat', '17:08, 30 February 2024', 'Mild (5.3 SR)', context),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget buildFilteringDialog(BuildContext context) {
  //   return Dialog(
  //     backgroundColor: Colors.transparent,
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: Colors.white.withOpacity(0.8),
  //         borderRadius: BorderRadius.circular(20),
  //         border: Border.all(color: Colors.white.withOpacity(0.3)),
  //       ),
  //       padding: const EdgeInsets.all(20),
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Text('Filtering', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
  //           SizedBox(height: 10),
  //           DropdownButton<String>(
  //             hint: Text('By Type'),
  //             value: selectedType,
  //             onChanged: (String? newValue) {
  //               setState(() {
  //                 selectedType = newValue;
  //               });
  //             },
  //             items: <String>['Earthquake', 'Volcano', 'Typhoon', 'Fire']
  //                 .map<DropdownMenuItem<String>>((String value) {
  //               return DropdownMenuItem<String>(
  //                 value: value,
  //                 child: Text(value),
  //               );
  //             }).toList(),
  //           ),
  //           DropdownButton<String>(
  //             hint: Text('By Time'),
  //             value: selectedTime,
  //             onChanged: (String? newValue) {
  //               setState(() {
  //                 selectedTime = newValue;
  //               });
  //             },
  //             items: <String>['Recent', 'Past Week', 'Past Month']
  //                 .map<DropdownMenuItem<String>>((String value) {
  //               return DropdownMenuItem<String>(
  //                 value: value,
  //                 child: Text(value),
  //               );
  //             }).toList(),
  //           ),
  //           DropdownButton<String>(
  //             hint: Text('By Criticality'),
  //             value: selectedCriticality,
  //             onChanged: (String? newValue) {
  //               setState(() {
  //                 selectedCriticality = newValue;
  //               });
  //             },
  //             items: <String>['Mild', 'Moderate', 'Severe']
  //                 .map<DropdownMenuItem<String>>((String value) {
  //               return DropdownMenuItem<String>(
  //                 value: value,
  //                 child: Text(value),
  //               );
  //             }).toList(),
  //           ),
  //           SizedBox(height: 20),
  //           ElevatedButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('Apply'),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

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
                                  getDisasterIcon(type),
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
                                  Text(
                                    '5.6',
                                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.blue),
                                  ),
                                  Text(
                                    'Richter Scale',
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
                              'https://maps.googleapis.com/maps/api/staticmap?center=$location&zoom=13&size=600x300&key=YOUR_API_KEY',
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