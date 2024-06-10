import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Report_Received extends StatefulWidget {
  @override
  _Report_ReceivedState createState() => _Report_ReceivedState();
}

class _Report_ReceivedState extends State<Report_Received> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text(
          'Report Rceived',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Report').where('status', isEqualTo: 'pending').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              final emergencyType = doc['emergency'];
              Widget? leadingIcon;

              // Memeriksa jenis bencana dan mengatur gambar yang sesuai
              switch (emergencyType) {
                case 'Fire':
                  leadingIcon = Image.asset(
                    'lib/icons/pngwing.com.png',
                    height: 50,
                    width: 50,
                  );
                  break;
                case 'Flood':
                  leadingIcon = Image.asset(
                    'lib/icons/landslide.png',
                    height: 50,
                    width: 50
                  );
                  break;
                case 'Earthquake':
                  leadingIcon = Image.asset(
                    'lib/icons/earthquake_earth_ground_floor_planet_natural_phenomenon_icon_194292.png',
                    height: 50,
                    width: 50
                  );
                  break;
                  case 'Tsunami':
                  leadingIcon = Image.asset(
                    'lib/icons/tsunami_wavesw_ave_sea_natural_phenomenon_icon_194273.png',
                    height: 50,
                    width: 50
                  );
                  break;
                  case 'Volcano':
                  leadingIcon = Image.asset(
                    'lib/icons/42463volcano_99098.png',
                    height: 50,
                    width: 50
                  );
                  break;
                  case 'Landslide':
                  leadingIcon = Image.asset(
                    'lib/icons/landslide_land_rocks_stones_slope_icon_194275.png',
                    height: 50,
                    width: 50
                  );
                  break;
                  case 'Typhoon':
                  leadingIcon = Image.asset(
                    'lib/icons/tornado_twister_weather_natural_phenomenon_wind_icon_194265.png',
                    height: 50,
                    width: 50
                  );
                  break;
                default:
                  leadingIcon = null;
              }
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12)
                ),
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: ListTile(
                  leading: leadingIcon,
                  title: Text(
                    doc['emergency'],
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name: ${doc['name']}',
                        style: const TextStyle(
                          color: Colors.grey
                        ),
                      ),
                      Text(
                        doc['address'],
                        style: const TextStyle(
                          color: Colors.grey
                        ),
                      ),
                    ],
                  ),
                  
                  onTap: () => _showReportDetails(doc),
                ),
              );
            }).toList(),
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
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => _updateReportStatus(doc.id, 'accepted'),
            style: TextButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 188, 45, 34),
              foregroundColor: Color.fromARGB(255, 255, 255, 255),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('Accept'),
          ),
          SizedBox(width: 5,),
          TextButton(
            onPressed: () => _updateReportStatus(doc.id, 'rejected'),
            style: TextButton.styleFrom(
              backgroundColor: Color.fromRGBO(249, 201, 116, 1),
              foregroundColor: const Color.fromARGB(255, 0, 0, 0),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('Reject'),
          ),
          SizedBox(width: 5,),
          if (doc['geolocation'] != null)
            TextButton(
              onPressed: () => _navigateToLocation(doc['geolocation']),
              child: Text('Navigate'),
              style: TextButton.styleFrom(
              backgroundColor: Color.fromRGBO(255, 255, 255, 1),
              foregroundColor: const Color.fromARGB(255, 0, 0, 0),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            ),
            SizedBox(width: 5,),
        ],
      ),
    );
  }

  Future _updateReportStatus(String docId, String status) async {
    await FirebaseFirestore.instance.collection('Report').doc(docId).update({'status': status});
    Navigator.of(context).pop();
    // Tambahkan logika untuk mengirim notifikasi ke pelapor
  }

  void _navigateToLocation(GeoPoint location) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationMapScreen(
          initialLocation: LatLng(location.latitude, location.longitude),
        ),
      ),
    );
  }
}

class LocationMapScreen extends StatelessWidget {
  final LatLng initialLocation;

  LocationMapScreen({required this.initialLocation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
        backgroundColor:Color.fromRGBO(255, 192, 65, 0.612),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: initialLocation,
          zoom: 14.0,
        ),
        markers: {
          Marker(
            markerId: MarkerId('reportLocation'),
            position: initialLocation,
          ),
        },
      ),
    );
  }
}
