import 'package:flutter/material.dart';

class Student {
  final String id;  
  final String name;
  final String phone;
  final String certificate;
  final String status;
  final String statusDate;
  final String situation;
  

  Student(
    {
    @required this.id,    
    @required this.name,
    @required this.phone,
    @required this.certificate,
    @required this.status,
    @required this.statusDate,
    @required this.situation
    
    }
  );

}

