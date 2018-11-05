import 'package:flutter/material.dart';

class HaberDuyuru {
  final String id;  
  final String numarasi;
  final String baslik;
  final String createdDate;
  final String okunma;
  final List<dynamic> icerik;
  

  HaberDuyuru(
    {
    @required this.id,    
    @required this.numarasi,
    @required this.baslik,
    @required this.createdDate,
    @required this.okunma,
    @required this.icerik

    }
  );

}

