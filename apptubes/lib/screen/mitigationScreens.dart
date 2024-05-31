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
      "name" : "VOLCANO",
      "image" : "lib/icons/42463volcano_99098.png", 
    },
    {
      "id" : 2,
      "tittle" : "Flood Mitigation Page",
      "page" : FloodPage(),
      "name" : "FLOOD",
      "image" : "lib/icons/landslide.png", 
    },
    {
      "id" : 3,
      "tittle" : "Tsunami Mitigation Page",
      "page" : TsunamiPage(),
      "name" : "TSUNAMI",
      "image" : "lib/icons/tsunami_wavesw_ave_sea_natural_phenomenon_icon_194273.png", 
    },
    {
      "id" : 4,
      "tittle" : "Earthquake Mitigation Page",
      "page" : EarthquakePage(),
      "name" : "EARTHQUAKE",
      "image" : "lib/icons/earthquake_earth_ground_floor_planet_natural_phenomenon_icon_194292.png", 
    },
    {
      "id" : 5,
      "tittle" : "Landslide Mitigation Page",
      "page" : LandslidePage(),
      "name" : "LANDSLIDE",
      "image" : "lib/icons/landslide_land_rocks_stones_slope_icon_194275.png", 
    },
    {
      "id" : 6,
      "tittle" : "Fire Mitigation Page",
      "page" : FirePage(),
      "name" : "FIRE",
      "image" : "lib/icons/pngwing.com.png", 
    },
    {
      "id" : 7,
      "tittle" : "Typhoon Mitigation Page",
      "page" : TyphoonPage(),
      "name" : "TYPHOON",
      "image" : "lib/icons/tornado_twister_weather_natural_phenomenon_wind_icon_194265.png", 
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
        backgroundColor: Colors.transparent,
        title: Text(
          'Mitigation',
          style: TextStyle(
            fontWeight: FontWeight.bold,
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
                    Text('${_weather?.temperature.round()}`C'),
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
                      onChanged: (value) => _runFilter(value),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search Tsunami, Earthquake, etc.',
                        prefixIcon: Icon(Icons.search_sharp)
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: _foundItems.isNotEmpty?
            ListView.builder(
              itemCount: _foundItems.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => Card(
                key: ValueKey(_foundItems[index]["id"]),
                color: Colors.white,
                elevation: 4,
                margin: const  EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                child: ElevatedButton(
                  onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
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
                        }
                      )
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              color: Colors.black
                            ),
                          )
                        ],
                      ),
                      Icon(Icons.arrow_circle_right_rounded, size: 50, color: Colors.black,),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
    );
  }
}