import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../../widgets/ui_elements/cikisyap_list_tile.dart';
import '../../scoped-models/main.dart';
import '../../models/student.dart';

class StudentsPage extends StatefulWidget {
  final MainModel model;

  StudentsPage(this.model);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StudentsPageState();
  }
}

class _StudentsPageState extends State<StudentsPage> {
  @override
  initState() {
    widget.model.fetchStudents();
    super.initState();
  }

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the Drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          // AppBar(
          //   automaticallyImplyLeading: false,
          //   //title: Text("Seçiniz"),
          // ),
          ScopedModelDescendant(
            builder: (BuildContext context, Widget child, MainModel model) {
              return UserAccountsDrawerHeader(
                accountName: Text("Ali TATLICI"),
                accountEmail: Text(model.kullanici.email),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Theme.of(context).platform == TargetPlatform.iOS ? Colors.purple : Colors.white,
                  backgroundImage: NetworkImage(
                    "http://isparta.edu.tr/resim.aspx?sicil_no=01582",
                  ),
                ),
                otherAccountsPictures: <Widget>[
                  CircleAvatar(
                  backgroundImage: NetworkImage(
                    "http://isparta.edu.tr/foto.aspx?sicil_no=01582",
                  ),
                )
                ],
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Personeller'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          ListTile(
            leading: Icon(Icons.school),
            title: Text('Öğrenciler'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/ogrenciler');
            },
          ),
          Divider(),
          CikisYapListTile()
        ],
      ),
    );
  }

  Widget _buildStudentsList() {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
      Widget content = Center(child: Text('Öğrenci bulunamadı!'));
      print("STUDENTS UZUNLUGUuuuuuuuuuuuuuuuuuuuuuuuu" + model.allStudents.length.toString());
      if (model.allStudents.length > 0 && !model.isYukleme) {
        content = ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: Key(model.allStudents[index].id),
          onDismissed: (DismissDirection direction) {
            if (direction == DismissDirection.endToStart) {
              model.selectPersonel(model.allStudents[index].id);
              model.silPersonel();
            }
          },
          background: Container(color: Colors.red),
          child: Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    "http://w3.sdu.edu.tr/foto.aspx?sicil_no=" +
                        model.allStudents[index].id,
                  ),
                ),
                title: Text(model.allStudents[index].name),
                subtitle: Text(model.allStudents[index].phone),
                ),
              Divider()
            ],
          ),
        );
      },
      itemCount: model.allStudents.length,
    );
      } else if (model.isYukleme) {
        content = Center(child: CircularProgressIndicator());
      }
      return RefreshIndicator(
        onRefresh: model.fetchStudents,
        child: content,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: _buildSideDrawer(context),
      appBar: AppBar(
        title: Text("Öğrenci Listesi"),
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
        actions: <Widget>[
          ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
              return IconButton(
                icon: Icon(model.displayedFavoriteOnly
                    ? Icons.favorite
                    : Icons.favorite_border),
                onPressed: () {
                  model.toogleGoruntuMode();
                },
              );
            },
          )
        ],
      ),
      body: _buildStudentsList(), 
    );
  }
}
