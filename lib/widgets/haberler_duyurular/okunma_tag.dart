import 'package:flutter/material.dart';

class OkunmaTag extends StatelessWidget {
  final String sayi;

  OkunmaTag(this.sayi);

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Icon(Icons.visibility, color: Colors.white,),
                      Text(
                    sayi,
                    style: TextStyle(color: Colors.white),
                  )
                    ],
                  ),
                );
    }
}