import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Metropolis',
  fontSize: 156.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Metropolis',
  fontSize: 24.0,
);

const kLargeTextStyle = TextStyle(
  fontSize: 72.0,
  fontFamily: 'Metropolis',
);

const kTextFieldDecoration = InputDecoration(
    filled: true,
    fillColor: Colors.white,
    hintText: 'Enter City Name',
    hintStyle: TextStyle(
      color: Colors.grey,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(30.0),
      ),
    ));
BorderRadius kborderRadius = BorderRadius.circular(15.0);
String? bgimage;
