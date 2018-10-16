import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:carousel_pro/carousel_pro.dart';

import '../widgets/ui_elements/drawer_custom.dart';
import '../scoped-models/main.dart';

class AnaSayfa extends StatefulWidget {
  final MainModel model;

  AnaSayfa(this.model);
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  Widget buildGrid(BuildContext context) {
    var spacecrafts = [
      "Profil",
      "ISUBÜ",
      "Yemekhane",
      "Kepler",
      "Juno",
      "Casini",
      "Columbia",
      "Challenger",
      "Huygens",
      "Galileo",
      "Apollo",
      "Spitzer",
      "WMAP",
      "Swift",
      "Atlantis"
    ];
    var myGridView = new GridView.builder(
      itemCount: spacecrafts.length,
      gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index) {
        return new GestureDetector(
          child: new Card(
            elevation: 5.0,
            child: new Container(
              //padding: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 20.0),
              alignment: Alignment.centerLeft,
              margin: new EdgeInsets.only(top: 20.0, bottom: 20.0, left: 20.0),
              child: new Text(spacecrafts[index]),
            ),
          ),
          onTap: () {
            showDialog(
                barrierDismissible: false,
                context: context,
                child: new CupertinoAlertDialog(
                  title: new Column(
                    children: <Widget>[
                      new Text("GridView"),
                      new Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                    ],
                  ),
                  content: new Text(spacecrafts[index]),
                  actions: <Widget>[
                    new FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: new Text("OK"))
                  ],
                ));
          },
        );
      },
    );
    return myGridView;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ISUBÜ Mobil"),
      ),
      drawer: DrawerCustom(),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            Container(
              child: SizedBox(
                  height: 200.0,
                  width: 400.0,
                  child: new Carousel(
                    images: [
                      new NetworkImage(
                          'https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
                      new NetworkImage(
                          'https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),
                      new ExactAssetImage("assets/sdu.jpg")
                    ],
                    dotSize: 4.0,
                    dotSpacing: 15.0,
                    dotColor: Colors.lightGreenAccent,
                    indicatorBgPadding: 5.0,
                    dotBgColor: Colors.lightBlue.withOpacity(0.5),
                    borderRadius: true,
                  )),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              height: 350.0,
              color: Colors.grey[250],
              child: GridView.count(
          crossAxisCount: 3,
          children: List.generate(choices.length, (index) {
              return Center(
                child: ChoiceCard(choice: choices[index]),
              );
           }
          ),),
            ),
          ],
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Profil', icon: Icons.perm_identity),
  const Choice(title: 'ISUBÜ', icon: Icons.home),
  const Choice(title: 'Yemekhane', icon: Icons.restaurant_menu),
  const Choice(title: 'Kısayol ekle', icon: Icons.add_circle_outline),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
        return GestureDetector(
                  child: Card(
            color: Colors.white,
            child: Center(child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(choice.icon, size:60.0, color: Colors.lightBlue),
                  Text(choice.title, style: TextStyle(fontSize: 16.0)),
            ]
          ),
      )
    ),
    onTap: () {
            showDialog(
                barrierDismissible: false,
                context: context,
                child: new CupertinoAlertDialog(
                  title: new Column(
                    children: <Widget>[
                      new Text("GridView"),
                      new Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                    ],
                  ),
                  content: new Text(choice.title),
                  actions: <Widget>[
                    new FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: new Text("OK"))
                  ],
                ));
          },
        );
  }
}