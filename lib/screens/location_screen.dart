import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/screens/city_screen.dart';
import 'package:weather_app/services/weather.dart';
import 'package:weather_app/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int? temp;
  String? cityName;
  String? condition;
  String? weatherIcon;
  String? weatherMessage;
  String? time;
  late String localtime;
  late double windspeed;
  late int humidity;
  int? rain;
  late String iconUrl;
  late String modifiedUrl;
  @override
  void initState() {
    super.initState();

    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temp = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        return;
      }
      double temperature = weatherData['current']['temp_c'];
      time = weatherData['location']['localtime'];

      temp = temperature.toInt();
      condition = weatherData['current']['condition']['text'];
      cityName = weatherData['location']['name'];
      localtime = weatherData['location']['localtime'];
      windspeed = weatherData['current']['wind_kph'];
      humidity = weatherData['current']['humidity'];
      rain = weatherData['forecast']?['forecastday']?['0']['day']
          ['daily_chance_of_rain'];
      iconUrl = weatherData['current']['condition']['icon'];
      modifiedUrl = iconUrl.replaceFirst('64x64', '128x128');

      if (rain == null) {
        rain = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Container(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(20.0),
                      child: IconButton(
                        onPressed: () async {
                          var weatherData = await weather.getLocationWeather();
                          updateUI(weatherData);
                        },
                        icon: Icon(
                          Icons.location_on_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(20.0),
                      child: IconButton(
                        onPressed: () async {
                          var typedName = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return CityScreen();
                              },
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.search,
                        ),
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '$cityName',
                            style: TextStyle(
                              fontSize: 64.0,
                            ),
                          ),
                          Text(
                            '$localtime ', // TODO Time
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(
                            height: 180.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                                child: Text(
                                  '$temp', //TODO Temperature data
                                  style: TextStyle(
                                    fontSize: 128.0,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                child: Icon(
                                  Icons.circle_outlined,
                                  size: 32,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                /* Image.network(
                                  'http:$modifiedUrl', // Replace with your image URL
                                  width: 100.0, // Set the width of the image
                                  height: 100.0,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  (loadingProgress
                                                          .expectedTotalBytes ??
                                                      1)
                                              : null,
                                        ),
                                      );
                                    }
                                  },
                                ), */ // TODO Weather Icon
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: Text(
                                    '$condition',
                                    style: TextStyle(
                                      fontSize: 24.0,
                                    ),
                                  ),
                                )
                              ]),
                          SizedBox(
                            height: 20.0,
                          ),
                          Divider(
                            color: Colors.grey, // Choose the color of your line
                            thickness: 1.0, // Set the thickness of the line
                            height: 40.0, // Set the height of the line
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              BottomValuesIndiacator(
                                text: 'Wind',
                                iconname: 'Icons/wind.svg',
                                value: '$windspeed km/h',
                              ),
                              BottomValuesIndiacator(
                                  text: 'Rain',
                                  iconname: 'Icons/rain.svg',
                                  value: '$rain %'),
                              BottomValuesIndiacator(
                                  text: 'Humidity',
                                  iconname: 'Icons/humidity.svg',
                                  value: '$humidity %')
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BottomValuesIndiacator extends StatelessWidget {
  String text;
  String value;
  String iconname;
  BottomValuesIndiacator(
      {super.key,
      required this.text,
      required this.iconname,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(text),
        SizedBox(
          height: 20,
        ),
        SvgPicture.asset(
          iconname,
          height: 40,
          width: 40,
          color: Colors.white,
        ),
        SizedBox(
          height: 20,
        ),
        Text(value),
      ],
    );
  }
}

/*

*/
