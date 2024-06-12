import 'package:apptubes/models/weatermodel.dart';
import 'package:apptubes/services/weaterservice.dart';
import 'package:flutter/material.dart';

import 'EmergencyContactPage.dart';
import 'RecentInformationPage.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _weatherService = weatherService('abe1b99a3ec5c3cb0c5d3ef43264d1ff');
  Weather? _weather;

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
                            color: Colors.black.withOpacity(0.1), // Shadow color with some transparency
                            blurRadius: 10.0, // Adjust blur radius for shadow softness
                            spreadRadius: 5.0, // Adjust spread radius for shadow extent
                            offset: Offset(-1.0, 1.0), // Offset the shadow in X and Y direction
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
                                      fontWeight: FontWeight.w600,
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
                              Text('Manacik, Karature',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            children: [
                              Icon(Icons.crisis_alert, color: Colors.red),
                              SizedBox(width: 8.0),
                              Text('Disaster Type: Earthquake'),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            children: [
                              Icon(Icons.warning, color: Colors.orange),
                              SizedBox(width: 8.0),
                              Text('Criticality: Mild'),
                            ],
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
                            color: Colors.black.withOpacity(0.1), // Shadow color with some transparency
                            blurRadius: 10.0, // Adjust blur radius for shadow softness
                            spreadRadius: 5.0, // Adjust spread radius for shadow extent
                            offset: Offset(-1.0, 1.0), // Offset the shadow in X and Y direction
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
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
