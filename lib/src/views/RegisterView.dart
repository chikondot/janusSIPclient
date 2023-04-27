import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:JanusSIPClient/src/utilities/ClientStrings.dart';
import 'package:JanusSIPClient/src/utilities/ClientAssets.dart';
import 'package:JanusSIPClient/src/utilities/ClientStorage.dart';
import 'package:JanusSIPClient/src/views/widgets/AlertView.dart';

class RegisterViewWidget extends StatefulWidget {
  @override
  RegisterViewWidgetState createState() => RegisterViewWidgetState();
}

class RegisterViewWidgetState extends State<RegisterViewWidget>
    with RegisterReusableWidgets, ReusableAlert {
  final formKey = GlobalKey<FormState>();

  bool screenLoading = false;

  final TextEditingController sipRegistrarField = new TextEditingController();
  final TextEditingController sipIdentityField = new TextEditingController();
  final TextEditingController sipUsernameField = new TextEditingController();
  final TextEditingController sipPasswordField = new TextEditingController();

  void initialViewInformation() async {}

  void persistViewInformation() async {
    Map<String, String> preferencesMap = {
      "registrar": "",
      "identity": "",
      "username": "",
      "password": "",
    };
    Storage.setMultipleStrings(preferencesMap);
  }

  // navigate to new page and save information
  void onButtonPressedCallback() async {
    if (formKey.currentState!.validate()) {
      persistViewInformation();

      this.setState(() {});
      handlePageNavigation();
    }
  }

  void handlePageNavigation() {
    Navigator.pushNamed(context, '/test');
  }

// *************************************************************
// *********** MAIN BUILD FUNCTION *****************************
// *************************************************************

  @override
  initState() {
    super.initState();

    initialViewInformation();
  }

  @override
  deactivate() {
    super.deactivate();

    persistViewInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
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
              inputTextField(sipRegistrarField, RegisterInputType.registrar),
              inputTextField(sipIdentityField, RegisterInputType.identity),
              inputTextField(sipUsernameField, RegisterInputType.username),
              inputTextField(sipPasswordField, RegisterInputType.password),
              screenLoading
                  ? new Container(
                      width: 50.0,
                      height: 20.0,
                      child: CircularProgressIndicator())
                  : new Container(),
              inputAcceptButton(context, onButtonPressedCallback),
            ],
          ),
        ),
      ),
    );
  }
}

enum RegisterInputType {
  registrar("SIP Registrar"),
  identity("SIP Identity"),
  username("SIP Username"),
  password("SIP Password");

  const RegisterInputType(this.label);

  final String label;
}

class RegisterReusableWidgets {
  Widget inputTextField(
    TextEditingController inputController,
    RegisterInputType inputType,
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
    if (value == null || value.isEmpty) return 'Input value is empty or null';
    return null;
  }

  Widget inputAcceptButton(BuildContext buildContext, Function() callback) =>
      new Material(
        elevation: 5.0,
        color: Assets.primaryColor,
        borderRadius: BorderRadius.circular(10.0),
        child: MaterialButton(
          minWidth: MediaQuery.of(buildContext).size.width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: callback,
          child: Text(
            Strings.registerButton,
            style: TextStyle(color: Assets.whiteColor),
            textAlign: TextAlign.center,
          ),
        ),
      );
}
