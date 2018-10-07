import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import './obs_anasayfa.dart';
import '../../scoped-models/main.dart';

class PersonelListeleSayfasi extends StatefulWidget {
  final MainModel model;

  PersonelListeleSayfasi(this.model);

  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return _PersonelListeleSayfasi();
    }
}

class _PersonelListeleSayfasi extends State<PersonelListeleSayfasi>{
  @override
  initState() {
    widget.model.fetchPersoneller(onlyForUser: true);
    super.initState();
  }

  Widget _buildDuzenleButonu(BuildContext context, int index, MainModel model) {
   return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        model.selectPersonel(model.allPersoneller[index].id);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return OBSAnaSayfa();
            },
          ),
        ).then((_) {
          model.selectPersonel(null);
        });
      },
    );
   }
  

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model) {
     return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: Key(model.allPersoneller[index].sicil),
          onDismissed: (DismissDirection direction) {
            if (direction == DismissDirection.endToStart) {
              model.selectPersonel(model.allPersoneller[index].id);
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
                        model.allPersoneller[index].sicil,
                  ),
                ),
                title: Text(model.allPersoneller[index].adSoyad),
                subtitle: Text(model.allPersoneller[index].bolum),
                trailing: _buildDuzenleButonu(context, index, model)
              ),
              Divider()
            ],
          ),
        );
      },
      itemCount: model.allPersoneller.length,
    );
   },); 
  }
}
