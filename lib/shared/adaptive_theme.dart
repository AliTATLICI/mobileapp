import 'package:flutter/material.dart';

final ThemeData _androidTheme = ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,         
          accentColor: Colors.deepPurple,
          buttonColor: Colors.blueAccent,
         
        );

final ThemeData _iOSTheme = ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.grey,         
          accentColor: Colors.blue,
          buttonColor: Colors.blue
         
        );


ThemeData getAdaptiveThemeData(context) {
  return Theme.of(context).platform == TargetPlatform.android ? _androidTheme : _iOSTheme;
}



// brightness: Brightness.light,
          //primarySwatch: Colors.blue,
          //primaryColor: defaultTargetPlatform == TargetPlatform.iOS ? Colors.grey[50] : Colors.blue,
          // accentColor: Colors.deepPurple,
          //buttonColor: Colors.blueAccent,
          // textTheme: Theme.of(context).textTheme.apply(
          //   bodyColor: Colors.black,
          //   displayColor: Colors.red
          // ),
          // primaryTextTheme: Theme
          //   .of(context)
          //   .primaryTextTheme
          //   .apply(bodyColor: Colors.white)