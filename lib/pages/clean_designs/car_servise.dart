import 'package:flutter/material.dart';

class CarServicePage extends StatefulWidget {
  @override
  _CarServicePageState createState() => _CarServicePageState();
}

class _CarServicePageState extends State<CarServicePage> with SingleTickerProviderStateMixin {

  TabController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.only(left: 15.0),
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 25.0),
                child: Icon(
                  Icons.camera_alt,
                  color: Color(0xFFEEB139),
                  size: 35.0,
                ),
              ),
              SizedBox(height: 20.0,),
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: Text(
                  'Your Current Vehicle',
                  style: TextStyle(
                    color: Color(0xFF434C68).withOpacity(0.7),
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    letterSpacing: 0.05
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              Image.asset('assets/anasayfa3.jpg', fit: BoxFit.cover, height: 175.0, width: MediaQuery.of(context).size.width - 30.0),
              Text(
                'PORSCHE',
                style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                '2019 - 911 CARREA S',
                style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF434C68)
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                height: 0.75,
                width: MediaQuery.of(context).size.width - 30,
                color: Color(0xFF343C68).withOpacity(0.4),
              ),
              SizedBox(height: 20.0,),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Icon(Icons.card_travel, color: Color(0xFF434C68).withOpacity(0.4)),
                        SizedBox(height: 5.0),
                        Text(
                          '19/24',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: 10.0),
                    Column(
                      children: <Widget>[
                        Icon(Icons.timer, color: Color(0xFF434C68).withOpacity(0.4)),
                        SizedBox(height: 5.0),
                        Text(
                          '3.2',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: 10.0),
                    Column(
                      children: <Widget>[
                        Icon(Icons.network_cell, color: Color(0xFF434C68).withOpacity(0.4)),
                        SizedBox(height: 5.0),
                        Text(
                          '443',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                height: 0.75,
                width: MediaQuery.of(context).size.width - 30,
                color: Color(0xFF434C68).withOpacity(0.4),
              ),
              SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  Icon(Icons.refresh, size: 35.0, color: Color(0xFF434C68).withOpacity(0.4)),
                  SizedBox(width: 10.0),
                   Text(
                    'EXCHANGE YOUR VEHICLE',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Icon(Icons.arrow_forward, size: 35.0, color: Color(0xFF434C68).withOpacity(0.4)),
                ],
              )

            ],
          )
        ],
      ),
      bottomNavigationBar: Material(
        color: Colors.white,
        child: TabBar(
          controller: controller,
          indicatorColor: Colors.transparent,
          tabs: <Widget>[
            Tab(icon: Icon(Icons.more, color: Colors.grey, size: 25.0)),
            Tab(icon: Icon(Icons.play_arrow, color: Colors.grey, size: 25.0)),
            Tab(icon: Icon(Icons.navigation, color: Colors.black, size: 25.0))
          ],
        ),
      ),
    );
  }
}