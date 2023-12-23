import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/utilities/constants.dart';

class FrostedEffect extends StatelessWidget {
  double height1;
  double width1;
  Widget childwidget;
  FrostedEffect(this.height1, this.width1, this.childwidget);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ClipRRect(
      borderRadius: kborderRadius,
      child: Container(
          width: width1,
          height: height1,
          child: Stack(children: [
            BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaY: 5,
                  sigmaX: 7,
                ),
                child: Container()),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: kborderRadius,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.5),
                    Colors.white.withOpacity(0.1),
                  ],
                ),
              ),
            ),
            Center(child: childwidget),
          ])),
    );
  }
}
