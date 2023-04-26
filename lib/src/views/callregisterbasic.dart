import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:JanusSIPClient/src/utilities/ClientAssets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CallSimpleRegisterWidget extends StatefulWidget {
  @override
  CallSimpleRegisterWidgetState createState() =>
      CallSimpleRegisterWidgetState();
}

class CallSimpleRegisterWidgetState extends State<CallSimpleRegisterWidget>
    with ReuseRegisterWidgets {
  // variable definitions
  final formKey = GlobalKey<FormState>();

  // --- Deprecated section
  final TextEditingController _username = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  final TextEditingController _domain = new TextEditingController();

  bool running = false;
  bool isLoading = false;

  SharedPreferences? _preferences;

  String _hashPassword = "";

  // --- Refactor section
  final TextEditingController sipRegistrarField = new TextEditingController();
  final TextEditingController sipIdentityField = new TextEditingController();
  final TextEditingController sipUsernameField = new TextEditingController();
  final TextEditingController sipPasswordField = new TextEditingController();

  // _preferences: should be moved to a singelton for SingleResponsibility and reuse

  // get information from storage of user settings (exec at init of page)
  void _loadSettings() async {
    _preferences = await SharedPreferences.getInstance();
    this.setState(() {});
  }

  _saveSettings() async {
    await _preferences?.setString('contact', _username.text);
    await _preferences?.setString(
        'sip_uri', "sip:${_username.text}@${_domain.text}");
    await _preferences?.setString('display_name', _username.text);
    await _preferences?.setString('password', _password.text);
    await _preferences?.setString('hash', _hashPassword);
    await _preferences?.setString('domain', _domain.text);
    await _preferences?.setBool('loggedIn', true);
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
            TextButton(
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

  // define login button with information posted to create user
  Widget loginButon() => new Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(10.0),
        color: Assets.primaryColor,
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () async {
            if (formKey.currentState!.validate()) {
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
            "Register",
            style: TextStyle(
              color: Assets.whiteColor,
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
                color: Assets.whiteColor,
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
                                "${Assets.splashScreenLogo}",
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            )),
                        SizedBox(height: 70.0),
                        inputTextField(sipRegistrarField, RegisterType.registrar),
                        SizedBox(height: 10.0),
                        inputTextField(sipIdentityField, RegisterType.identity),
                        SizedBox(height: 10.0),
                        inputTextField(sipUsernameField, RegisterType.username),
                        SizedBox(height: 10.0),
                        inputTextField(sipPasswordField, RegisterType.password),
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

enum RegisterType {
  registrar("SIP Registrar"),
  identity("SIP Identity"),
  username("SIP Username"),
  password("SIP Password");

  const RegisterType(this.label);

  final String label;
}

class ReuseRegisterWidgets {
  // -- Refactor to make input field reusable
  @override
  Widget inputTextField(
    TextEditingController inputController,
    RegisterType inputType,
  ) {
    return new Container(
      child: TextFormField(
        controller: inputController,
        keyboardType: TextInputType.text,
        validator: validationCheck,
        maxLines: 1,
        decoration: InputDecoration(
          hintText: "Enter ${inputType.label}:",
          labelText: "${inputType.label}:",
          contentPadding: EdgeInsets.fromLTRB(20.0, 14.0, 0.0, 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  String? validationCheck(String? value) {
    if (value != null) if (value.isEmpty) return 'Input value is empty or null';
    return null;
  }
}
