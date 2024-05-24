import 'package:flutter/material.dart';

class VolcanoPage extends StatelessWidget {
  const VolcanoPage({Key? key}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("lib/icons/42463volcano_99098.png"),
            Text(
              'Volcano',
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FloodPage extends StatelessWidget {
  const FloodPage({Key? key}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("lib/icons/landslide.png"),
            Text(
              'Flood',
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TsunamiPage extends StatelessWidget {
  const TsunamiPage({Key? key}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("lib/icons/tsunami_wavesw_ave_sea_natural_phenomenon_icon_194273.png"),
            Text(
              'Tsunami',
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      ),
    );
  }
}

class EarthquakePage extends StatelessWidget {
  const EarthquakePage({Key? key}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("lib/icons/earthquake_earth_ground_floor_planet_natural_phenomenon_icon_194292.png"),
            Text(
              'Earthquake',
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LandslidePage extends StatelessWidget {
  const LandslidePage({Key? key}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("lib/icons/landslide_land_rocks_stones_slope_icon_194275.png"),
            Text(
              'Landslide',
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      ),
    );
  }
}


