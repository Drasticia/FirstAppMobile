// import 'package:apptubes/models/weatermodel.dart';
// import 'package:apptubes/services/weaterservice.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
// import 'EmergencyContactPage.dart';
// import 'RecentInformationPage.dart';
//
// class HomeScreen extends StatefulWidget {
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final _weatherService = weatherService('abe1b99a3ec5c3cb0c5d3ef43264d1ff');
//   Weather? _weather;
//   final User? user = FirebaseAuth.instance.currentUser;
//
//   _fetchWeather() async {
//     String cityname = await _weatherService.getCurrentlyCity();
//
//     try {
//       final weather = await _weatherService.getWeather(cityname);
//       setState(() {
//         _weather = weather;
//       });
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchWeather();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.transparent,
//         title: Text(
//           'SAFE Home',
//           style: TextStyle(
//             fontWeight: FontWeight.w700,
//             fontSize: 25,
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.all(16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Icon(
//                       Icons.location_on_outlined,
//                       size: 35,
//                     ),
//                     SizedBox(width: 8.0),
//                     Text(_weather?.cityname ?? "loading city.."),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Text('${_weather?.temperature.round()}°C'),
//                     SizedBox(width: 8.0),
//                     Icon(
//                       Icons.wb_sunny_outlined,
//                       size: 30,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => RecentInformationPage()),
//                       );
//                     },
//                     child: Container(
//                       margin: EdgeInsets.all(10.0),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(15),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 10.0,
//                             spreadRadius: 5.0,
//                             offset: Offset(-1.0, 1.0),
//                           ),
//                         ],
//                       ),
//                       padding: EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Recent Information',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18,
//                             ),
//                           ),
//                           SizedBox(height: 8.0),
//                           Container(
//                             decoration: BoxDecoration(
//                               border: Border.all(color: Colors.grey),
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             padding: EdgeInsets.all(16.0),
//                             child: Row(
//                               children: [
//                                 SizedBox(width: 16.0),
//                                 Center(
//                                   child: Text(
//                                     'Harusnya disini live map',
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 8.0),
//                           Row(
//                             children: [
//                               Icon(Icons.location_on, color: Colors.blue),
//                               SizedBox(width: 8.0),
//                               Text(
//                                 'Manacik, Karature',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 8.0),
//                           Row(
//                             children: [
//                               Icon(Icons.crisis_alert, color: Colors.red),
//                               SizedBox(width: 8.0),
//                               Text('Disaster Type: Earthquake'),
//                             ],
//                           ),
//                           SizedBox(height: 8.0),
//                           Row(
//                             children: [
//                               Icon(Icons.warning, color: Colors.orange),
//                               SizedBox(width: 8.0),
//                               Text('Criticality: Mild'),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => EmergencyContactPage()),
//                       );
//                     },
//                     child: Container(
//                       margin: EdgeInsets.all(10.0),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(15),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 10.0,
//                             spreadRadius: 5.0,
//                             offset: Offset(-1.0, 1.0),
//                           ),
//                         ],
//                       ),
//                       padding: EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             child: Text(
//                               'Emergency Contact',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 18,
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 16.0),
//                           Container(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Aparatur Negara',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 17,
//                                   ),
//                                 ),
//                                 ListTile(
//                                   leading: CircleAvatar(
//                                     child: Text('PL'),
//                                   ),
//                                   title: Text('Polisi'),
//                                   trailing: IconButton(
//                                     onPressed: () async {
//                                       await FlutterPhoneDirectCaller.callNumber('+6281283115727');
//                                     },
//                                     icon: ImageIcon(
//                                       AssetImage("lib/icons/call.png"),
//                                       size: 23.0,
//                                       color: Colors.blue,
//                                     ),
//                                   ),
//                                 ),
//                                 ListTile(
//                                   leading: CircleAvatar(
//                                     child: Text('PK'),
//                                   ),
//                                   title: Text('Pemadam Kebakaran'),
//                                   trailing: IconButton(
//                                     onPressed: () async {
//                                       await FlutterPhoneDirectCaller.callNumber('+6281283115727');
//                                     },
//                                     icon: ImageIcon(
//                                       AssetImage("lib/icons/call.png"),
//                                       size: 23.0,
//                                       color: Colors.blue,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 20),
//                           Container(
//                             child: Text(
//                               'Keluarga atau Kerabat',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 17,
//                               ),
//                             ),
//                           ),
//                           StreamBuilder<QuerySnapshot>(
//                             stream: FirebaseFirestore.instance
//                                 .collection('emergency contact')
//                                 .where('email', isEqualTo: user?.email)
//                                 .limit(7)
//                                 .snapshots(),
//                             builder: (context, snapshot) {
//                               if (snapshot.connectionState == ConnectionState.waiting) {
//                                 return Center(child: CircularProgressIndicator());
//                               }
//                               if (snapshot.hasError) {
//                                 return Center(child: Text('Error: ${snapshot.error}'));
//                               }
//                               if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                                 return Center(child: Text('No contacts available'));
//                               }
//                               return Column(
//                                 children: snapshot.data!.docs.map((DocumentSnapshot document) {
//                                   Map<String, dynamic> data = document.data() as Map<String, dynamic>;
//                                   return ListTile(
//                                     leading: CircleAvatar(
//                                       child: Text(data['name'][0].toUpperCase()),
//                                     ),
//                                     title: Text(data['name']),
//                                     subtitle: Text(data['phoneNumber']),
//                                     trailing: IconButton(
//                                       onPressed: () async {
//                                         await FlutterPhoneDirectCaller.callNumber(data['phoneNumber']);
//                                       },
//                                       icon: ImageIcon(
//                                         AssetImage("lib/icons/call.png"),
//                                         size: 23.0,
//                                         color: Colors.blue,
//                                       ),
//                                     ),
//                                   );
//                                 }).toList(),
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:apptubes/models/weatermodel.dart';
import 'package:apptubes/services/weaterservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'EmergencyContactPage.dart';
import 'RecentInformationPage.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _weatherService = weatherService('abe1b99a3ec5c3cb0c5d3ef43264d1ff');
  Weather? _weather;
  final User? user = FirebaseAuth.instance.currentUser;

  _fetchWeather() async {
    String cityname = await _weatherService.getCurrentlyCity();

    try {
      final weather = await _weatherService.getWeather(cityname);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text(
          'SAFE Home',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 25,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 35,
                    ),
                    SizedBox(width: 8.0),
                    Text(_weather?.cityname ?? "loading city.."),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('${_weather?.temperature.round()}°C'),
                    SizedBox(width: 8.0),
                    Icon(
                      Icons.wb_sunny_outlined,
                      size: 30,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RecentInformationPage()),
                      );
                    },
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
                            'Recent Information',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
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
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      padding: EdgeInsets.all(16.0),
                                      child: Row(
                                        children: [
                                          SizedBox(width: 16.0),
                                          Center(
                                            child: Text(
                                              'Harusnya disini live map',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: [
                                        Icon(Icons.location_on, color: Colors.blue),
                                        SizedBox(width: 8.0),
                                        Text(data['address']),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: [
                                        Icon(Icons.crisis_alert, color: Colors.red),
                                        SizedBox(width: 8.0),
                                        Text('Disaster Type: ${data['emergency']}'),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: [
                                        Icon(Icons.warning, color: Colors.orange),
                                        SizedBox(width: 8.0),
                                        Text('Criticality: ${data['detailedInformation']}'),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: [
                                        Icon(Icons.access_time, color: Colors.grey),
                                        SizedBox(width: 8.0),
                                        Text('Time: $timestamp'),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EmergencyContactPage()),
                      );
                    },
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
                          Container(
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Aparatur Negara',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                  ),
                                ),
                                ListTile(
                                  leading: CircleAvatar(
                                    child: Text('PL'),
                                  ),
                                  title: Text('Polisi'),
                                  trailing: IconButton(
                                    onPressed: () async {
                                      await FlutterPhoneDirectCaller.callNumber('+6281283115727');
                                    },
                                    icon: ImageIcon(
                                      AssetImage("lib/icons/call.png"),
                                      size: 23.0,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                                ListTile(
                                  leading: CircleAvatar(
                                    child: Text('PK'),
                                  ),
                                  title: Text('Pemadam Kebakaran'),
                                  trailing: IconButton(
                                    onPressed: () async {
                                      await FlutterPhoneDirectCaller.callNumber('+6281283115727');
                                    },
                                    icon: ImageIcon(
                                      AssetImage("lib/icons/call.png"),
                                      size: 23.0,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            child: Text(
                              'Keluarga atau Kerabat',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('emergency contact')
                                .where('email', isEqualTo: user?.email)
                                .limit(2)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(child: CircularProgressIndicator());
                              }
                              if (snapshot.hasError) {
                                return Center(child: Text('Error: ${snapshot.error}'));
                              }
                              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                return Center(child: Text('No contacts available'));
                              }
                              return Column(
                                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                  Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                                  return ListTile(
                                    leading: CircleAvatar(
                                      child: Text(data['name'][0].toUpperCase()),
                                    ),
                                    title: Text(data['name']),
                                    subtitle: Text(data['phoneNumber']),
                                    trailing: IconButton(
                                      onPressed: () async {
                                        await FlutterPhoneDirectCaller.callNumber(data['phoneNumber']);
                                      },
                                      icon: ImageIcon(
                                        AssetImage("lib/icons/call.png"),
                                        size: 23.0,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  );
                                }).toList(),
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
          ),
        ],
      ),
    );
  }
}
