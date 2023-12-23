import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/frostedEffect.dart';
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
  final GlobalKey _columnKey = GlobalKey();

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
  var screenSize;
  late double deviceWidth;
  late int isDay;
  late String bgimage;

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
        windspeed = 0;
        rain = 0;
        humidity = 0;
        localtime = '';
        condition = 'Not Found';
        showWeatherDataNotFoundPopup();

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
      isDay = weatherData['current']['is_day'];
      if (rain == null) {
        rain = 0;
      }

      if (isDay == 1) {
        bgimage = 'images/day.png';
      } else {
        bgimage = 'images/bgimage.png';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

    // Get the device width
    deviceWidth = screenSize.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bgimage),
            fit: BoxFit.cover,
          ),
        ),
        child: Expanded(
          child: ListView(
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
                        icon: SvgPicture.asset(
                          'Icons/location.svg',
                          height: 50,
                          width: 50,
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
                          if (typedName != null) {
                            var weatherData =
                                await weather.getCityWeather(typedName);
                            updateUI(weatherData);
                          }
                        },
                        icon: SvgPicture.asset('Icons/search.svg'),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                  child: Container(
                    child: FrostedEffect(
                      500,
                      deviceWidth,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '$cityName',
                            style: kLargeTextStyle,
                          ),
                          Text('$localtime ', // TODO Time
                              style:
                                  kMessageTextStyle.copyWith(fontSize: 18.0)),
                          SizedBox(
                            height: 50.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                                child: Text(
                                  '$temp', //TODO Temperature data
                                  style: kTempTextStyle,
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
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                                child: Text(
                                  'C',
                                  style: kTempTextStyle.copyWith(fontSize: 78),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text('$condition',
                              style: kMessageTextStyle.copyWith(fontSize: 48)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                child: Divider(
                  color: Colors.white,
                  thickness: 1.0,
                  indent: 10.0,
                  endIndent: 10.0,
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    BottomValuesIndiacator(
                      text: 'Wind',
                      iconname: 'Icons/wind.svg',
                      value: '$windspeed km/h',
                    ),
                    BottomValuesIndiacator(
                      text: 'Rain',
                      iconname: 'Icons/rain.svg',
                      value: '$rain %',
                    ),
                    BottomValuesIndiacator(
                      text: 'Humidity',
                      iconname: 'Icons/humidity.svg',
                      value: '$humidity %',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showWeatherDataNotFoundPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Weather Data Not Found"),
          content: Text("Please check the city entered."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Optionally, you can add code to handle this situation
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}

// Your existing BottomValuesIndiacator class...

class BottomValuesIndiacator extends StatelessWidget {
  String text;
  String value;
  String iconname;
  BottomValuesIndiacator({
    super.key,
    required this.text,
    required this.iconname,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return FrostedEffect(
      200,
      150,
      Container(
        width: 150,
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text,
                style: kMessageTextStyle,
              ),
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
              Text(
                value,
                style: kMessageTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
