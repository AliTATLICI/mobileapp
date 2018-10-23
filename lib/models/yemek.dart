import 'package:flutter/material.dart';

class Yemek { 
  final String tarih;
  final String gun;
  final List menu;  
  final String kalori;

  Yemek(
    {  
    @required this.tarih,
    @required this.gun,
    @required this.menu,
    @required this.kalori

    }
  );

}

