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
                              ? (report['timestamp'] as Timestamp)
                                  .toDate()
                                  .toString()
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
      child: Container(
        constraints: BoxConstraints(minHeight: 120), // Atur tinggi minimum agar semua kartu memiliki tinggi yang sama
        child: ListTile(
          leading: IconTheme(
            data: IconThemeData(
              size: 40,
              color: Theme.of(context).primaryColor,
            ),
            child: getDisasterIcon(type),
          ),
          title: Text(
            type,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Lokasi: ',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: location,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Waktu: ',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: time,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Keterangan: ',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: criticality,
                      style: TextStyle(
                        fontSize: 16,
                        color: criticality == 'High' ? Colors.red : Colors.grey[700],
                      ),
                    ),
                  ],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          trailing: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor, // Warna background tombol
              foregroundColor: Colors.white, // Warna teks tombol
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
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
      ),
    );
  }


  Widget getDisasterIcon(String type) {
    switch (type) {
      case 'Earthquake':
        return Image.asset(
          'lib/icons/gempaIcon.png',
          width: 40,
          height: 40,
        );
      case 'Flood':
        return Image.asset(
          'lib/icons/banjirIcon.png',
          width: 40,
          height: 40,
        );
      case 'Typhoon':
        return Image.asset(
          'lib/icons/anginTopanIcon.png',
          width: 40,
          height: 40,
        );
      case 'Fire':
        return Image.asset(
          'lib/icons/kebakaranIcon.png',
          width: 40,
          height: 40,
        );
      case 'Volcano':
        return Image.asset(
          'lib/icons/gunungMeletusIcon.png',
          width: 40,
          height: 40,
        );
      case 'Landslide':
        return Image.asset(
          'lib/icons/landslide_land_rocks_stones_slope_icon_194275.png',
          width: 40,
          height: 40,
        );
      default:
        return Icon(Icons.error, color: Colors.grey);
    }
  }
}
