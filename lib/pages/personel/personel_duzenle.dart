import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../../widgets/helpers/ensure_visible.dart';
import '../../models/personel.dart';
import '../../scoped-models/main.dart';

class PersonelDuzenleSayfasi extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PersonelDuzenleSayfasiState();
  }
}

class _PersonelDuzenleSayfasiState extends State<PersonelDuzenleSayfasi> {
  final Map<String, dynamic> _formData = {
    'adiSoyadi': null,
    'sicil': null,
    'eposta': null,
    'cep': null,
    'bolum': null
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _adiSoyadiFocusNode = FocusNode();
  final _sicilFocusNode = FocusNode();
  final _epostaFocusNode = FocusNode();
  final _bolumFocusNode = FocusNode();
  final _cepFocusNode = FocusNode();

  Widget _buildAdiSoyadiTextField(Personel personel) {
    return EnsureVisibleWhenFocused(
      focusNode: _adiSoyadiFocusNode,
      child: TextFormField(
        focusNode: _adiSoyadiFocusNode,
        decoration: InputDecoration(labelText: 'Adı-Soyadı'),
        initialValue: personel == null ? '' : personel.adSoyad,
        //autovalidate: true,
        validator: (String value) {
          //if (value.trim().length <= 0) return 'Ad-Soyad boş olamaz.';
          if (value.isEmpty || value.length < 5)
            return 'Ad-Soyad boş olamaz. En az 5 karakterli olmalıdır';
        },
        onSaved: (String value) {
          _formData['adiSoyadi'] = value;
        },
      ),
    );
  }

  Widget _buildSicilTextField(Personel personel) {
    return EnsureVisibleWhenFocused(
      focusNode: _sicilFocusNode,
      child: TextFormField(
        focusNode: _sicilFocusNode,
        decoration: InputDecoration(labelText: 'Sicil Numarası'),
        initialValue: personel == null ? '' : personel.sicil,
        validator: (String value) {
          //if (value.trim().length <= 0) return 'Ad-Soyad boş olamaz.';
          if (value.isEmpty || value.length != 5)
            return 'Sicil boş olamaz. 5 karakterli olmalıdır Örn: 05432';
        },
        onSaved: (String value) {
          _formData['sicil'] = value;
        },
      ),
    );
  }

  Widget _buildEpostaTextField(Personel personel) {
    return EnsureVisibleWhenFocused(
      focusNode: _epostaFocusNode,
      child: TextFormField(
        focusNode: _epostaFocusNode,
        decoration: InputDecoration(labelText: 'E-posta Adresi'),
        initialValue: personel == null ? '' : personel.eposta,
        validator: (String value) {
          //if (value.trim().length <= 0) return 'Ad-Soyad boş olamaz.';
          if (value.isEmpty) return 'Eposta boş olamaz.';
        },
        onSaved: (String value) {
          _formData['eposta'] = value;
        },
      ),
    );
  }

  Widget _buildBolumTextField(Personel personel) {
    return EnsureVisibleWhenFocused(
      focusNode: _bolumFocusNode,
      child: TextFormField(
        focusNode: _bolumFocusNode,
        decoration: InputDecoration(labelText: 'Bölümü'),
        initialValue: personel == null ? '' : personel.bolum,
        onSaved: (String value) {
          _formData['bolum'] = value;
        },
      ),
    );
  }

  Widget _buildCepTextField(Personel personel) {
    return EnsureVisibleWhenFocused(
      focusNode: _cepFocusNode,
      child: TextFormField(
        focusNode: _cepFocusNode,
        decoration: InputDecoration(labelText: 'Cep Telefonu'),
        initialValue: personel == null ? '' : personel.cep,
        keyboardType: TextInputType.phone,
        onSaved: (String value) {
          _formData['cep'] = value;
        },
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.isYukleme
            ? Center(child: CircularProgressIndicator())
            : RaisedButton(
                child: Text("Kaydet"),
                textColor: Colors.white,
                onPressed: () => _submitForm(
                    model.eklePersonel,
                    model.guncellePersonel,
                    model.selectPersonel,
                    model.selectedPersonelIndex),
              );
      },
    );
  }

  Widget _buildPageContent(BuildContext context, Personel personel) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;
    return GestureDetector(
      onTap: () {
        ///Form alanında değer girerken boş bi yere tıkladığımızda klavye yi kaldırmak için
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
            children: <Widget>[
              _buildAdiSoyadiTextField(personel),
              _buildSicilTextField(personel),
              _buildEpostaTextField(personel),
              _buildBolumTextField(personel),
              _buildCepTextField(personel),
              SizedBox(
                height: 10.0,
              ),
              _buildSubmitButton()
              // GestureDetector(
              //   onTap: _submitForm,
              //   child: Container(
              //     alignment: Alignment.bottomCenter,
              //     color: Colors.cyanAccent,
              //     padding: EdgeInsets.all(5.0),
              //     child: Text('Kaydet'),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm(Function eklePersonel, Function guncellePersonel,
      Function setSelectedPersonel,
      [int selectedPersonelIndex]) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    if (selectedPersonelIndex == -1) {
      eklePersonel(
          _formData['adiSoyadi'],
          _formData['sicil'],
          _formData['eposta'],
          _formData['bolum'],
          _formData['cep']).then((bool success) {
        if (success) {
          Navigator
              .pushReplacementNamed(context, '/personeller')
              .then((_) => setSelectedPersonel(null));
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Bir şeyler yanlış gitti!'),
              content: Text('Lütfen tekrar deneyin!'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Tamam'),
                )
              ],
            );
          });
        }
      });
    } else {
      guncellePersonel(_formData['adiSoyadi'], _formData['sicil'],
              _formData['eposta'], _formData['bolum'], _formData['cep'])
          .then((_) => Navigator
              .pushReplacementNamed(context, '/personeller')
              .then((_) => setSelectedPersonel(null)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final Widget pageContent =
            _buildPageContent(context, model.selectedPersonel);
        return model.selectedPersonelIndex == -1
            ? pageContent
            : Scaffold(
                appBar: AppBar(
                  title: Text('Personel Düzenleme'),
                ),
                body: pageContent,
              );
      },
    );
  }
}
