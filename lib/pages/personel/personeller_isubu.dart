import 'package:flutter/material.dart';
import 'package:flutter_course/models/personel.dart';
import 'package:flutter_course/scoped-models/main.dart';
import 'package:flutter_course/widgets/ui_elements/drawer_custom.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import 'dart:convert';
import './ISUBU.dart';

class PersonellerISUBU extends StatefulWidget {
  

  @override
  _PersonellerISUBUState createState() => _PersonellerISUBUState();
}

class _PersonellerISUBUState extends State<PersonellerISUBU> {
  String url = "http://192.168.1.35:8000/pbs/personeller/";

  final List<PersonelISUBU> personelList;

   @override
  void initState() {
    super.initState();
  }

  Widget myCard() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1.0),
          itemCount: personelList.length,
          itemBuilder: (context, index) => Card(
                child: Stack(
                  children: <Widget>[

                  ],
                ),
              ),
        );
      },
    );
  }

  Widget myBody() {
    return personelList == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : myCard();
  }

 

  fetchPersoneller() async {
    var res = await http.get(url);
    var decodedRes = jsonDecode(utf8.decode(res.bodyBytes));
    print(decodedRes['results']);
    final Map<String, dynamic> personelListData = decodedRes['results'];
    //final Map<String, dynamic> personel = decodedRes['results'];

    setState(() {});
    //print(personel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: DrawerCustom(),
      appBar: AppBar(
        title: Text('ISUBU Personelleri'),
      ),
      body: myBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchPersoneller,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
