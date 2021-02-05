import 'package:clima/Location.dart';
import 'package:clima/services/networking.dart';

const apiKey = '4aaf076c1f0c40ba94d107ba3827b89c';
class WeatherModel {
  Future<dynamic> getWeatherCity(String cityName) async{
    var networkHelper= NetworkHelper('api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric');
    var weatherData= await networkHelper.getData();
    return weatherData;
  }
  Future<dynamic> getWeatherLocation()async{
    Location location = Location();
    await location.getLocation();

    NetworkHelper networkHelper=NetworkHelper('http://api.openweathermap.org/data/2.5/weather?lat=${location.longitude}&lon=${location.longitude}'
        '&appid=$apiKey&units=metric');
    var weatherData=await networkHelper.getData();
    return weatherData;
  }
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
