import 'dart:convert';
import 'package:apptubes/models/weatermodel.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class weatherService{
  static const BASE_URL = 'http://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  weatherService(this.apiKey);

  Future<Weather> getWeather(String cityname) async {
    final respons = await http .get(Uri.parse('$BASE_URL?q=$cityname&appid=$apiKey&units=metric'));

    if (respons.statusCode == 200){
      return Weather.fromJson(jsonDecode(respons.body));
    }else{
      throw Exception('Failde to load');
    }
  }

  Future<String> getCurrentlyCity() async{
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    String? city = placemarks[0].locality;

    return city ?? "";
  }
}