/*

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
                          print("yemekhane sayfasına gitmesi lazım**********************");
                         Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => YemekhaneSayfasi()),
  );
                        },
                        child: new Text("OK"))
                  ],
                ));
*/