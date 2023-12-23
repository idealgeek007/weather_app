import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Metropolis-Regular',
  fontSize: 100.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Metropolis-Regular',
  fontSize: 24.0,
);

const kLargeTextStyle = TextStyle(
  fontSize: 48.0,
  fontFamily: 'Metropolis-Regular',
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
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
