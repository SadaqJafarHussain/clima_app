import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen(this.data);
  final  data;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  double temperature;
  String weatherIcon;
  String cityName;
  String weatherMessage;
  int temp;
  @override
  void initState() {
    super.initState();
    update(widget.data);
  }
  void update(dynamic weatherData){
    if(weatherData==null){
      temperature=0;
      weatherIcon='';
      cityName='';
      weatherMessage='we can\'t reach you ';
      return;
    }
    temperature=weatherData['main']['temp'];
     temp=temperature.toInt();
     var condition=weatherData['weather'][0]['id'];
     weatherIcon=WeatherModel().getWeatherIcon(condition);
    cityName=widget.data['name'];
    weatherMessage=WeatherModel().getMessage(temp);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async{
                      var weatherData= await WeatherModel().getWeatherLocation();
                      update(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var cityName=await Navigator.push(context,
                          MaterialPageRoute(builder: (context)
                              =>CityScreen(),),);
                      print(cityName);
                      //if(cityName!=null){
                       // var data= WeatherModel().getWeatherCity(cityName);
                       // update(data);
                     // }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temp°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text(
                    "$weatherMessage in $cityName!",
                    textAlign: TextAlign.right,
                    style: kMessageTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
