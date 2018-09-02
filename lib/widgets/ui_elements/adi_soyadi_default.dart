import 'package:flutter/material.dart';

class AdiSoyadiDefault extends StatelessWidget {
  final String adiSoyadi;

  AdiSoyadiDefault(this.adiSoyadi);
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(
      adiSoyadi,
      style: TextStyle(
        fontSize: 20.0, 
        fontWeight: FontWeight.bold,
        fontFamily: 'Oswald'),
    );
  }
}
