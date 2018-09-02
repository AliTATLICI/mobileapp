import 'package:flutter/material.dart';

class Personel {
  final String id;  
  final String adSoyad;
  final String sicil;
  final String eposta;  
  final String bolum;
  final String cep;  
  // final String userId;
  final bool isFavorite;
  final String userEmail;
  final String userId;

  Personel(
    {
    @required this.id,    
    @required this.adSoyad,
    @required this.sicil,
    @required this.eposta,
    @required this.bolum, 
    @required this.cep,
    @required this.userEmail,
    @required this.userId,      
    // @required this.userId,
    this.isFavorite = false

    }
  );

}

