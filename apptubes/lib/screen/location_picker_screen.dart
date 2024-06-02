import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';

class LocationPickerScreen extends StatefulWidget {
  @override
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  GoogleMapController? _controller;
  LatLng? _pickedLocation;
  Position? _currentPosition;
  String? _address;
  final String _apiKey = 'AIzaSyCzksH2MXN7R0PFZdm65iwGRD_FupWRFzU'; // Ganti dengan API Key Anda
  late GoogleMapsPlaces _places;

  @override
  void initState() {
    super.initState();
    _places = GoogleMapsPlaces(apiKey: _apiKey);
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      _currentPosition = position;
    });
    if (_controller != null) {
      _controller?.moveCamera(
        CameraUpdate.newLatLng(
          LatLng(position.latitude, position.longitude),
        ),
      );
    }
  }

  Future<void> _selectLocation(LatLng location) async {
    setState(() {
      _pickedLocation = location;
    });
    await _getAddressFromLatLng(location);
  }

  Future<void> _getAddressFromLatLng(LatLng location) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(location.latitude, location.longitude);
      Placemark place = placemarks[0];
      setState(() {
        _address = "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _handleSearch() async {
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: _apiKey,
      mode: Mode.overlay, // Mode.fullscreen to display search in fullscreen mode
      language: "en",
      components: [Component(Component.country, "id")], // Batasi pencarian ke negara tertentu
    );

    if (p != null) {
      await _displayPrediction(p);
    }
  }

  Future<void> _displayPrediction(Prediction p) async {
    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId!);
    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;
    final location = LatLng(lat, lng);

    _controller?.animateCamera(CameraUpdate.newLatLng(location));
    await _selectLocation(location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Location'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _handleSearch,
          ),
        ],
      ),
      body: Stack(
        children: [
          if (_currentPosition != null)
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  _currentPosition!.latitude,
                  _currentPosition!.longitude,
                ),
                zoom: 16,
              ),
              onMapCreated: (controller) {
                _controller = controller;
                _controller?.moveCamera(
                  CameraUpdate.newLatLng(
                    LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                  ),
                );
              },
              onTap: _selectLocation,
              markers: _pickedLocation == null
                  ? {}
                  : {
                Marker(
                  markerId: MarkerId('selected-location'),
                  position: _pickedLocation!,
                ),
              },
            )
          else
            Center(child: CircularProgressIndicator()),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: _pickedLocation == null
                  ? null
                  : () {
                Navigator.pop(context, _address);
              },
              child: Text('Confirm Location'),
            ),
          ),
        ],
      ),
    );
  }
}
