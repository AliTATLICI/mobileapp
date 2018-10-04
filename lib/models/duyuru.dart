import 'package:flutter/material.dart';

class Duyuru {
  final String id;  
  final String numarasi;
  final String baslik;
  final String createdDate;  
  final List<dynamic> icerik;
  

  Duyuru(
    {
    @required this.id,    
    @required this.numarasi,
    @required this.baslik,
    @required this.createdDate,
    @required this.icerik

    }
  );

}

