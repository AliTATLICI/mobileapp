import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../../scoped-models/main.dart';
import '../../models/auth.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
    'acceptTerms': false
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTextController = TextEditingController();
  AuthMode _authMode = AuthMode.Login;

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop),
      image: AssetImage('assets/sdu.jpg'),
    );
  }

  Widget _buildEpostaTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'E-mail', filled: true, fillColor: Colors.white),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'Geçerli bir eposta adresi giriniz!';
        }
      },
      onSaved: (String value) {
        _formData['email'] = value;
      },
    );
  }

  Widget _buildParolaTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Parola', filled: true, fillColor: Colors.white),
      obscureText: true,
      controller: _passwordTextController,
      validator: (String value) {
        if (value.isEmpty || value.length < 6) {
          return 'Parola geçerli değil.';
        }
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  Widget _buildPasswordConfirmTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Confirm Password', filled: true, fillColor: Colors.white),
      keyboardType: TextInputType.emailAddress,
      obscureText: true,
      validator: (String value) {
        if (_passwordTextController.text != value) {
          return 'Parolalar eşleşmiyor!';
        }
      },
    );
  }

  Widget _buildAcceptSwitch() {
    return SwitchListTile(
      value: _formData['acceptTerms'],
      onChanged: (bool value) {
        setState(() {
          _formData['acceptTerms'] = value;
        });
      },
      title: Text('Şartı Kabul Et'),
    );
  }

  void _gonderForm(Function authenticate) async {
    if (!_formKey.currentState.validate() || !_formData['acceptTerms']) {
      return;
    }
    _formKey.currentState.save();
    Map<String, dynamic> successInformation;
    successInformation =  await authenticate(_formData['email'], _formData['password'], _authMode);        
    if (successInformation['success']) {
        Navigator.pushReplacementNamed(context, '/');
    } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Bir Hata Oluştu!'),
                content: Text(successInformation['message']),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Okay'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            },);
    }
    // print('EMAIL :' + _formData['email']);
    // print('PASSWORD' + _formData['password']);
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targeteWidth =
        deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    return Scaffold(
        appBar: AppBar(
          title: Text('Giriş'),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: _buildBackgroundImage(),
          ),
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                width: targeteWidth,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      _buildEpostaTextField(),
                      SizedBox(
                        height: 10.0,
                      ),
                      _buildParolaTextField(),
                      SizedBox(
                        height: 10.0,
                      ),
                      _authMode == AuthMode.Signup
                          ? _buildPasswordConfirmTextField()
                          : Container(),
                      _buildAcceptSwitch(),
                      SizedBox(
                        height: 10.0,
                      ),
                      FlatButton(
                        child: Text(
                            'Switch to ${_authMode == AuthMode.Login ? 'Signup' : 'Login'}'),
                        onPressed: () {
                          setState(() {
                            _authMode = _authMode == AuthMode.Login
                                ? AuthMode.Signup
                                : AuthMode.Login;
                          });
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      ScopedModelDescendant(
                        builder: (BuildContext context, Widget child,
                            MainModel model) {
                          return model.isYukleme
                              ? CircularProgressIndicator()
                              : RaisedButton(
                                  textColor: Colors.white,
                                  child: Text(_authMode == AuthMode.Login
                                      ? 'GİRİŞ'
                                      : 'KAYDOL'),
                                  onPressed: () =>
                                      _gonderForm(model.kimlikdogrulama),
                                );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
