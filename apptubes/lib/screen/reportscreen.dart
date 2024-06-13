import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'location_picker_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  // Variable Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _detailedInformationController = TextEditingController();
  final User? user = FirebaseAuth.instance.currentUser;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  bool isForMyself = true;
  String selectedEmergency = '';
  String selectedLocationAddress = '[Selected Location]';
  LatLng? selectedLocation;
  List<String> emergencies = [
    'Fire',
    'Flood',
    'Earthquake',
    'Tsunami',
    'Volcano',
    'Landslide',
    'Typhoon'
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    _detailedInformationController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text(
          'Report',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                ToggleButtons(
                  borderRadius: BorderRadius.circular(10),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 46),
                      child: Text(
                        'For Myself',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17),
                      child: Text(
                        'For Someone Else',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                  isSelected: [isForMyself, !isForMyself],
                  onPressed: (int index) {
                    setState(() {
                      isForMyself = index == 0;
                    });
                  },
                  renderBorder: true,
                  selectedBorderColor: Colors.grey.shade400,
                  fillColor: const Color.fromRGBO(249, 201, 116, 1),
                  borderColor: Colors.grey.shade400,
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  ),
                  controller: _nameController,
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  ),
                  controller: _phoneNumberController,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    var result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LocationPickerScreen(),
                      ),
                    );
                    if (result != null) {
                      setState(() {
                        selectedLocationAddress = result['address'];
                        selectedLocation = LatLng(result['lat'], result['lng']);
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(249, 201, 116, 1),
                    padding: EdgeInsets.symmetric(horizontal: 100, vertical: 12),
                    foregroundColor: Colors.black,
                    textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 20,
                        color: Colors.black,
                      ),
                      SizedBox(width: 4),
                      Text('Select Location'),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text('Location: $selectedLocationAddress'),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Detail Location',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  ),
                  controller: _detailedInformationController,
                ),
                SizedBox(height: 15),
                Text(
                  'Select Emergency',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children: emergencies.map((emergency) {
                    return ChoiceChip(
                      label: Text(emergency),
                      selected: selectedEmergency == emergency,
                      selectedColor: const Color.fromRGBO(249, 201, 116, 1),
                      onSelected: (bool selected) {
                        setState(() {
                          selectedEmergency = selected ? emergency : '';
                        });
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _addReportDetails(context);
                  },
                  child: Text(
                    'Send Report',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    backgroundColor: const Color.fromRGBO(190, 48, 0, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Create data on Firestore
  Future _addReportDetails(BuildContext context) async {
  String name = _nameController.text;
  String phoneNumber = _phoneNumberController.text;
  GeoPoint? geolocation = selectedLocation != null ? GeoPoint(selectedLocation!.latitude, selectedLocation!.longitude) : null;
  String detailedInformation = _detailedInformationController.text;
  String emergency = selectedEmergency;
  String address = selectedLocationAddress;
  String email = user?.email ?? '';

  if (name.isNotEmpty && phoneNumber.isNotEmpty && emergency.isNotEmpty) {
    await FirebaseFirestore.instance.collection('Report').add({
      'name': name,
      'phonenumber': phoneNumber,
      'email': email,
      'geolocation': geolocation,
      'address': address,
      'detailedInformation': detailedInformation,
      'emergency': emergency,
      'status': 'pending', // Status laporan
      'timestamp': FieldValue.serverTimestamp(), // Waktu laporan
    });

    // Tampilkan dialog konfirmasi setelah laporan berhasil dikirim
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.check_circle_outline_outlined,
                size: 150,
                color: const Color.fromRGBO(249, 201, 116, 1),
              ),
              Text(
                'Report Has Been Sent',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(190, 48, 0, 1),
                  textStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 70, vertical: 15),
                ),
                child: Text(
                  'DONE',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  } else {
    print("Create gagal");
  }
}
}
