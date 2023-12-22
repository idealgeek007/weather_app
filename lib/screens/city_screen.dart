import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:weather_app/utilities/constants.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String? cityName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset(
                  'Icons/back.svg',
                  height: 50,
                  width: 50,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: SvgPicture.asset(
                        'Icons/city.svg',
                        height: 30,
                        width: 30,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: TextField(
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: kTextFieldDecoration,
                        onChanged: (value) {
                          cityName = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context, cityName);
                },
                child: Text(
                  'GET WEATHER',
                  style: kButtonTextStyle.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
