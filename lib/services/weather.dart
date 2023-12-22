import 'networking.dart';
import 'location.dart';

const apikey = '801c2fd8726c4230bb473334230512';
const weatherApi = 'http://api.weatherapi.com/v1/current.json?key=$apikey';

class WeatherModel {
  Future<dynamic> getCityWeather(String typedname) async {
    var url =
        'https://api.weatherapi.com/v1/current.json?key=$apikey&q=$typedname&aqi=no#';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    // create network helper object and get weather Data
    NetworkHelper networkHelper = NetworkHelper(
        '$weatherApi&q=${location.latitude},${location.longitude}&aqi=no');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }
}
