import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:apptubes/models/weatermodel.dart';
import 'package:apptubes/services/weaterservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'EmergencyContactPage.dart';
import 'RecentInformationPage.dart';
import 'package:apptubes/models/weatermodel.dart';
import 'package:apptubes/services/weaterservice.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _weatherService = weatherService('abe1b99a3ec5c3cb0c5d3ef43264d1ff');
  Weather? _weather;
  final User? user = FirebaseAuth.instance.currentUser;
  String? _currentAddress;
  Position? _currentPosition;
  double? _currentTemperature;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _fetchWeather(double lat, double lon) async {
    String apiKey = '84397f34ccc06a716f6b880f6bc35f89';
    String url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _currentTemperature = data['main']['temp'];
          print('Current temperature: $_currentTemperature');
        });
      } else {
        print('Failed to load weather data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      return;
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('Location permissions are permanently denied, we cannot request permissions.');
      return;
    }

    // Get the current position
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print('Current position: $position');
      setState(() {
        _currentPosition = position;
      });
      _getAddressFromLatLng(position);
      _fetchWeather(position.latitude, position.longitude); // Fetch weather after getting the position
    } catch (e) {
      print('Error getting current position: $e');
    }
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        setState(() {
          _currentAddress =
          "${place.locality}, ${place.postalCode}, ${place.country}";
          print('Current address: $_currentAddress');
        });
      } else {
        print('No placemarks found.');
      }
    } catch (e) {
      print('Error getting address from coordinates: $e');
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
                    Text(_currentAddress ?? "loading location..."),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(_currentTemperature != null
                        ? '${_currentTemperature!.round()}°C'
                        : 'temp null'),
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
                          Text(
                            'Kontak Darurat',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
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
                          SizedBox(height: 20),
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('emergency contact')
                                .where('email', isEqualTo: user?.email)
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
