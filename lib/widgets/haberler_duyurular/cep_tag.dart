import 'package:flutter/material.dart';

class CepTag extends StatelessWidget {
  final String cep;

  CepTag(this.cep);

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Container(
        width: MediaQuery.of(context).size.width * 2.8 / 12.0,
                  padding: EdgeInsets.symmetric(vertical: 3.0),
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