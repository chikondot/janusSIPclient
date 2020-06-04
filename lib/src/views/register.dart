import 'dart:async';
import 'dart:math';

import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart'; 

import 'package:janus_sip_client/src/communication/grpc.dart';
import 'package:janus_sip_client/src/information/dealer.dart';
import 'package:quiver/async.dart';
import 'package:shared_preferences/shared_preferences.dart';



class RegisterWidget extends StatefulWidget {
  @override
  RegisterWidgetState createState() => RegisterWidgetState();
}

class RegisterWidgetState extends State<RegisterWidget> {
  final _formKey = GlobalKey<FormState>();

  // text controllers for input information
  final TextEditingController _phoneController = new TextEditingController();
  final TextEditingController _codeController = new TextEditingController();

  // timer for SMS delivery
  Timer _timer;
  int _timeStart = 180;
  int _timeCurrent = 180;

  bool _running = false;
  bool _isLoading = false;

  // variables to store information
  String _verificationCode;
  String _username;
  String _password;

  Country _selectCountry = Country.ZW; // default country to zimbabwe
  SharedPreferences _preferences;

  // define communication to server
  GRPCServer server = new GRPCServer();

  // *************************************************************
  // *********** LOCAL FUNCTION DEFINITIONS **********************
  // *************************************************************

  // generate unique password for each user to be saved
  String _genPassword() {
    String pool =
        "abcdefghilklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
    Random random = new Random();
    List<int> units = new List.generate(
      10,
      (index) {
        return pool.codeUnitAt(random.nextInt(61));
      },
    );
    return String.fromCharCodes(units);
  }

  // sms delivery timer for allowing resends
  void _smsTimer() {
    this.setState(() {
      _running = true;
    });
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: _timeStart),
      new Duration(seconds: 1),
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      if (mounted)
        setState(() {
          _timeCurrent = _timeStart - duration.elapsed.inSeconds;
        });
    });

    sub.onDone(() {
      if (mounted)
        this.setState(() {
          _running = false;
        });
      print("DEBUG : TIMER DONE!");
      sub.cancel();
    });
  }

  // init registration process for a new user
  Future<void> userRegister() async {
    _verificationCode = _codeController.text;
    // user information and request
    final response =
        await server.sendUserCreate(_username, _password, _verificationCode);

    if (response == null) {
      // send user status update onError
      FlushbarHelper.createError(
        title: "note:",
        message: "Failed to connect to network.",
        duration: Duration(seconds: 3),
      )..show(context);
      return;
    } else {
      print("verify parsed showing: ${response.result}");

      if (response.result == "Created!") {
        // send user status update onSuccess
        FlushbarHelper.createSuccess(
          title: "success:",
          message: "${response.result}",
          duration: Duration(seconds: 3),
        )..show(context);

        // init registration and move to next page
        _handleSave(context);
      } else if (response.result == "Updated!") {
        // send user status update onSuccess
        FlushbarHelper.createSuccess(
          title: "success:",
          message: "${response.result}",
          duration: Duration(seconds: 3),
        )..show(context);

        // init registration and move to next page
        _handleSave(context);
      } else {
        // send user status update onError
        FlushbarHelper.createError(
          title: "note:",
          message: "Failed to login user",
          duration: Duration(seconds: 3),
        )..show(context);

        await _preferences.setBool('loggedIn', false);
        return;
      }
    }
  }

  // init sms generation for otp to new user
  Future<void> userVerify() async {
    // send server request for SMS verification
    final response = await server.sendUserVerification(_username);

    if (response == null) {
      // send user status update onError
      FlushbarHelper.createError(
        title: "note:",
        message: "An error occurred. Please retry later.",
        duration: Duration(seconds: 3),
      )..show(context);
      return;
    } else if (response.result == "Message Sent!") {
      // send user status update onSuccess
      FlushbarHelper.createSuccess(
        title: "success:",
        message: "${response.result}",
        duration: Duration(seconds: 3),
      )..show(context);
      return;
    }

    // send user status update onError
    FlushbarHelper.createError(
      title: "note:",
      message: "An error unkown occurred. Please retry later.",
      duration: Duration(seconds: 3),
    )..show(context);
    return;
  }

  // get information from storage of user settings (exec at init of page)
  void _loadSettings() async {
    _preferences = await SharedPreferences.getInstance();
    await _preferences.setString('password', _genPassword());
    this.setState(() {
      _password = _preferences.getString('password');
      print(
          "PASWORDS >>>>>>>>> GEN(${_preferences.getString('password')}) VS SET($_password)");
    });
  }

  // presist setting set in page to storage
  void _saveSettings() {
    _preferences.setString('contact', _username);
    _preferences.setString('sip_uri', "$_username@${Dealer.domain}");
    _preferences.setString('display_name', _username);
    _preferences.setString('password', _password);
    _preferences.setString('auth_user', _username);
    _preferences.setBool('loggedIn', true);
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
    Navigator.pushNamed(context, '/home');
  }

  // *************************************************************
  // *********** WIDGETS AS FUNCTIONS ****************************
  // *************************************************************

  // field for inputing phone number detail
  Widget phoneField() => new Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new CountryPicker(
              showDialingCode: false,
              showName: false,
              onChanged: (Country country) {
                setState(
                  () {
                    _selectCountry = country;
                  },
                );
              },
              selectedCountry: _selectCountry,
            ),
            Expanded(
              child: TextFormField(
                maxLines: 1,
                controller: _phoneController,
                decoration: InputDecoration(
                  hintText: "Phone number",
                  labelText: "Phone number",
                  contentPadding: EdgeInsets.fromLTRB(20.0, 14.0, 0.0, 20.0),
                  prefix: new Text(
                    _selectCountry == null
                        ? '+263'
                        : '+' + _selectCountry.dialingCode,
                    style: TextStyle(color: Dealer.mainColor),
                  ),
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
            ),
          ],
        ),
      );

  // field to init sms generation and input verification code
  Widget verifyField() => new Container(
        child: TextFormField(
          keyboardType: TextInputType.number,
          controller: _codeController,
          decoration: InputDecoration(
            suffix: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              color: Dealer.mainColor,
              splashColor: Dealer.mainColor,
              onPressed: _running
                  ? () {}
                  : () async {
                      // set username variable
                      _username = "+" +
                          _selectCountry.dialingCode +
                          "" +
                          _phoneController.text;

                      // validation that numbers are correct
                      if (_username.length < 6) {
                        // return information back to user
                        FlushbarHelper.createError(
                            message: "Enter a valid phone number",
                            duration: Duration(seconds: 3))
                          ..show(context);
                        return;
                      }

                      // start timer to disable retries
                      _smsTimer();

                      // proceed to send SMS to username
                      userVerify();
                    },
              child: Text(
                _running ? "$_timeCurrent" : "Get code",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            contentPadding: EdgeInsets.fromLTRB(20.0, 0.0, 7.0, 10.0),
            hintText: "Verification code",
            labelText: "Verification code",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter the verification code';
            }
            return null;
          },
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
            if (_formKey.currentState.validate()) {
              _username =
                  "+" + _selectCountry.dialingCode + "" + _phoneController.text;

              // validation that numbers are correct
              if (_username.length < 6) {
                return;
              }

              // proceed to send create user account and navigate
              userRegister();
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
    // _phoneController.dispose();
    // _codeController.dispose();
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
                    key: _formKey,
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
                        verifyField(),
                        SizedBox(
                          height: 5.0,
                        ),
                        _isLoading
                            ? new Container(
                                width: 50.0,
                                height: 20.0,
                                // child: LoadingIndicator(
                                //   indicatorType: Indicator.ballPulse,
                                //   color: Dealer.mainColor,
                                // ))
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
