import 'package:clima/Location.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}
class _LoadingScreenState extends State<LoadingScreen> {
  void initState() {
    super.initState();
    getLocation();
  }
  void getLocation() async {

   var weatherData= await WeatherModel().getWeatherLocation();
    Navigator.push(context, MaterialPageRoute(builder: (context)=>LocationScreen(weatherData)));
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SpinKitWave(
          color: Colors.lightGreen,
          size: 200.0,
        ),
      ),
    );
  }
}
