import 'package:apptubes/screen/pagemitigation.dart';
import 'package:flutter/material.dart';

import '../models/weatermodel.dart';
import '../services/weaterservice.dart';

class MitigationPage extends StatefulWidget {
  const MitigationPage({super.key});

  @override
  State<MitigationPage> createState() => _MitigationPageState();
}

class _MitigationPageState extends State<MitigationPage> {
  final _weatherService =weatherService('abe1b99a3ec5c3cb0c5d3ef43264d1ff');
  Weather? _weather;

  _fetchWeather() async {
    String cityname = await _weatherService.getCurrentlyCity();

    try{
      final weather = await _weatherService.getWeather(cityname);
      setState(() {
        _weather = weather;
      });
    }

    catch (e){
      print(e);
    }
  }
  final List<Map<String, dynamic>> _allListItem = [
    {
      "id" : 1,
      "tittle" : "Volcano Mitigation Page",
      "page" : VolcanoPage(),
      "name" : "Erupsi",
      "image" : "lib/icons/gunungMeletusIcon.png",
    },
    {
      "id" : 2,
      "tittle" : "Flood Mitigation Page",
      "page" : FloodPage(),
      "name" : "Banjir",
      "image" : "lib/icons/banjirIcon.png",
    },
    {
      "id" : 3,
      "tittle" : "Tsunami Mitigation Page",
      "page" : TsunamiPage(),
      "name" : "Tsunami",
      "image" : "lib/icons/tsunami_wavesw_ave_sea_natural_phenomenon_icon_194273.png",
    },
    {
      "id" : 4,
      "tittle" : "Earthquake Mitigation Page",
      "page" : EarthquakePage(),
      "name" : "Gempa Bumi",
      "image" : "lib/icons/gempaIcon.png",
    },
    {
      "id" : 5,
      "tittle" : "Landslide Mitigation Page",
      "page" : LandslidePage(),
      "name" : "Longsor",
      "image" : "lib/icons/landslide_land_rocks_stones_slope_icon_194275.png",
    },
    {
      "id" : 6,
      "tittle" : "Fire Mitigation Page",
      "page" : FirePage(),
      "name" : "Kebakaran",
      "image" : "lib/icons/kebakaranIcon.png",
    },
    {
      "id" : 7,
      "tittle" : "Typhoon Mitigation Page",
      "page" : TyphoonPage(),
      "name" : "Angin Topan",
      "image" : "lib/icons/anginTopanIcon.png",
    },
  ];

  List<Map<String, dynamic>> _foundItems = [];

  @override
  void initState(){
    _foundItems = _allListItem;
    super.initState();
    _fetchWeather();

  }

  void _runFilter(String enteredKeyboard){
    List<Map<String, dynamic>> result = [];
    if (enteredKeyboard.isEmpty){
      result = _allListItem;
    }else{
      result = _allListItem.where((user) => user["name"].toLowerCase().contains(enteredKeyboard.toLowerCase())).toList();
    }
    setState(() {
      _foundItems = result;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text(
          'Mitigation',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: Stack(
        children: [
          // Background container with transparency
          Container(
            decoration: BoxDecoration(
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          onChanged: (value) => _runFilter(value),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search Tsunami, Earthquake, etc.',
                              hintStyle: TextStyle(
                                color: Colors.grey
                              ),
                              prefixIcon: Icon(Icons.search_sharp)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                  child: _foundItems.isNotEmpty
                      ? ListView.builder(
                    itemCount: _foundItems.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) => Card(
                      key: ValueKey(_foundItems[index]["id"]),
                      color: Colors.white,
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 7),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                                return Scaffold(
                                  appBar: AppBar(
                                    title: Text(
                                      _foundItems[index]['tittle'],
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: Colors.black,
                                  ),
                                  body: _foundItems[index]['page'],
                                );
                              }));
                        },
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  _foundItems[index]['image'],
                                  height: 75,
                                ),
                                SizedBox(width: 25),
                                Text(
                                  _foundItems[index]['name'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Colors.black),
                                )
                              ],
                            ),
                            Icon(
                              Icons.arrow_circle_right_rounded,
                              size: 50,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  )
                      : const Text(
                    'No Result Found',
                    style: TextStyle(fontSize: 24),
                  )
                ),
            ],
          ),
        ],
      ),
    );
  }
}