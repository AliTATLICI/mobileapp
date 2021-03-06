import 'package:flutter/material.dart';

class CepTag extends StatelessWidget {
  final String cep;

  CepTag(this.cep);

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Text(
                    cep,
                    style: TextStyle(color: Colors.white),
                  ),
                );
    }
}