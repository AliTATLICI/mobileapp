import 'package:flutter/material.dart';

class HaberBasligi extends StatelessWidget {
  final String haberBasligi;

  HaberBasligi(this.haberBasligi);
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final TextTheme textTheme = Theme.of(context).textTheme;
    // style: TextStyle(decoration: TextDecoration.none)
    return Expanded(
          child: Center(
                      child: Text(
        haberBasligi,
        style: TextStyle(
        fontSize: 13.0, 
        fontWeight: FontWeight.bold,
        fontFamily: 'Oswald'),
      ),
          ),
    );
  }
}
