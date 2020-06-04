import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:janus_sip_client/src/information/dealer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CallSimpleRegisterWidget extends StatefulWidget {
  @override
  CallSimpleRegisterWidgetState createState() =>
      CallSimpleRegisterWidgetState();
}

class CallSimpleRegisterWidgetState extends State<CallSimpleRegisterWidget> {
  // variable definitions
  final formKey = GlobalKey<FormState>();

  final TextEditingController _username = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  final TextEditingController _domain = new TextEditingController();

  bool running = false;
  bool isLoading = false;

  SharedPreferences _preferences;

  String _hashPassword;

  // get information from storage of user settings (exec at init of page)
  void _loadSettings() async {
    _preferences = await SharedPreferences.getInstance();
    this.setState(() {});
  }

  _saveSettings() async {
    await _preferences.setString('contact', _username.text);
    await _preferences.setString(
        'sip_uri', "sip:${_username.text}@${_domain.text}");
    await _preferences.setString('display_name', _username.text);
    await _preferences.setString('password', _password.text);
    await _preferences.setString('hash', _hashPassword);
    await _preferences.setString('domain', _domain.text);
    await _preferences.setBool('loggedIn', true);
  }

  _getHash(TextEditingController _controller) {
    if (_controller.text != null) {
      String input = "${_username.text}:${_domain.text}:${_controller.text}";
      return md5.convert(utf8.encode(input)).toString();
    }
    throw "DEBUG ::: ERROR >>> NO HASH FOR PASSWORD";
  }

  // set alert to user on action to be completed
  void _alert(BuildContext context, String alertFieldName) {
    showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$alertFieldName is empty'),
          content: Text('Please enter $alertFieldName!'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // get settings and ensure information present, whilst setting of UAC
  void _handleSave(BuildContext context) {
    // error checking
    if (_username == null) {
      _alert(context, "USERNAME!");
    } else if (_password == null) {
      _alert(context, "PASSWORD!");
    }

    // naviagte to new page and save information
    Navigator.pushNamed(context, '/test');
  }

  // field for inputing phone number detail
  Widget phoneField() => new Container(
        child: TextFormField(
          maxLines: 1,
          controller: _username,
          decoration: InputDecoration(
            hintText: "Enter username: ",
            labelText: "Username: ",
            contentPadding: EdgeInsets.fromLTRB(20.0, 14.0, 0.0, 20.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          validator: (value) {
            if (value.isEmpty) {
              // validation that non empty
              return 'Please enter your phone number';
            } else if (value.length < 6) {
              // validation that numbers are correct
              return 'Please enter a valid phone number';
            }

            return null;
          },
          keyboardType: TextInputType.phone,
          onSaved: (String value) {},
        ),
      );

  // field to init sms generation and input verification code
  Widget passwordField() => new Container(
        child: TextFormField(
          maxLines: 1,
          controller: _password,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 0.0, 7.0, 10.0),
            hintText: "Enter Password: ",
            labelText: "Password: ",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter password';
            }
            return null;
          },
          keyboardType: TextInputType.text,
          onSaved: (String value) {},
        ),
      );

  Widget domainField() => new Container(
        child: TextFormField(
          maxLines: 1,
          controller: _domain,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 0.0, 7.0, 10.0),
            hintText: "Enter Domain: ",
            labelText: "Domain: ",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter domain';
            }
            return null;
          },
          keyboardType: TextInputType.text,
          onSaved: (String value) {},
        ),
      );

  // define login button with information posted to create user
  Widget loginButon() => new Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(10.0),
        color: Dealer.mainColor,
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () async {
            if (formKey.currentState.validate()) {
              _hashPassword = _getHash(_password);
              _saveSettings();

              // validation that numbers are correct
              if (_username.text.length < 6 || _password == null) {
                return;
              }

              this.setState(() {});
              _handleSave(context);
            }
          },
          child: Text(
            "Login",
            style: TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );

  // *************************************************************
  // *********** MAIN BUILD FUNCTION *****************************
  // *************************************************************

  @override
  initState() {
    super.initState();
    _loadSettings();
  }

  @override
  deactivate() {
    super.deactivate();
    _saveSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        SizedBox(height: 130.0),
                        SizedBox(
                            height: 155.0,
                            child: new ClipRRect(
                              borderRadius: new BorderRadius.circular(8.0),
                              child: Image.asset(
                                "${Dealer.splash}",
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            )),
                        SizedBox(height: 70.0),
                        phoneField(),
                        SizedBox(height: 10.0),
                        domainField(),
                        SizedBox(height: 10.0),
                        passwordField(),
                        SizedBox(
                          height: 5.0,
                        ),
                        isLoading
                            ? new Container(
                                width: 50.0,
                                height: 20.0,
                                child: CircularProgressIndicator())
                            : new Container(),
                        SizedBox(
                          height: 5.0,
                        ),
                        loginButon(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
