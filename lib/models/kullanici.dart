import 'package:flutter/material.dart';

class Kullanici {
  final String id;
  final String email;
  final String token;
  final String username;
  final String firstName;
  final String lastName;

  Kullanici({
    @required this.id,
    @required this.email,
    @required this.token,
    @required this.username,
    @required this.firstName,
    @required this.lastName
  });
}
