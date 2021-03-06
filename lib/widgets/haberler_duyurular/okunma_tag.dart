import 'package:flutter/material.dart';

class OkunmaTag extends StatelessWidget {
  final String sayi;

  OkunmaTag(this.sayi);

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Container(
        width: MediaQuery.of(context).size.width * 2.8 / 14.0,
                  padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 1.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.visibility, color: Colors.white,),
                      Text(
                    sayi,
                    style: TextStyle(color: Colors.white), textDirection: TextDirection.ltr,
                  )
                    ],
                  ),
                );
    }
}