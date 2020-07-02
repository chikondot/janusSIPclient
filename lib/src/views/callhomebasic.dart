import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgets/noKBEt.dart';

class CallInputWidget extends StatefulWidget {
  @override
  CallInputWidgetSate createState() => CallInputWidgetSate();
}

class CallInputWidgetSate extends State<CallInputWidget> {
  final TextEditingController _destination = new TextEditingController();

  SharedPreferences _preferences;
  String _account;
  _loadSettings() async {
    _preferences = await SharedPreferences.getInstance();
    if (_preferences.containsKey('contact')) {
      _account = _preferences.getString('contact');
    }
    this.setState(() {});
  }

  _saveSettings() async {
    await _preferences.setString('destination', _destination.text);
  }

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

  _handleCall(BuildContext buildContext) {
    // check ::: if destination information has been set
    if (_destination.text == null || _destination.text.isEmpty) {
      showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // show ::: dialog if no destination
          return AlertDialog(
            title: Text('Target is empty.'),
            content: Text('Please enter a number to dail!'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return null;
    }
    // set ::: call destination and go to calling screen
    this.setState(() {});
    _preferences.setString('destination', _destination.text);
    Navigator.pushNamed(context, '/call');
  }

  void _handleBackSpace([bool deleteAll = false]) {
    var text = _destination.text;
    if (text.isNotEmpty) {
      this.setState(() {
        // check ::: remove characters or all from text
        text = deleteAll ? '' : text.substring(0, text.length - 1);
        _destination.text = text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Home"),
          backgroundColor: Color(0xff6b406b),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                      GestureDetector(
                        child: Text("Balance: \$0,00",
                            style: TextStyle(color: Colors.white)),
                        onTap: () {},
                      ),
                    ])))
          ]),
      body: SafeArea(child: dialPad(context)),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            _drawerHeader(),
            SizedBox(
              height: 8.0,
            ),
            ListTile(
              leading: Icon(
                Icons.account_balance_wallet,
                color: Color(0xff6b406b),
              ),
              title: Text(
                'Account',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w300,
                  color: Color(0xff6b406b),
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/local');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerHeader() {
    // check ::: is account information set
    if (_account == null) _account = "Please sign in";

    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Color(0xff6b406b),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 50.0,
            left: 16.0,
            child: new Icon(
              Icons.account_circle,
              size: 28.0,
              color: Colors.white,
            ),
          ),
          Positioned(
            bottom: 12.0,
            left: 16.0,
            child: Text(
              "$_account",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget dialPad(BuildContext context) {
    List<String> numbers = [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "*",
      "0",
      "#",
    ];
    List<String> alpha = [
      "",
      "abc",
      "def",
      "ghi",
      "jkl",
      "mno",
      "pqrs",
      "tuv",
      "wxyz",
      "",
      "+",
      "",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        new Padding(
          padding: EdgeInsets.only(left: 40.0, right: 40.0, bottom: 5.0),
          child: new NoKeyboardEditableText(
            controller: _destination,
            style: TextStyle(fontSize: 30.0, color: Colors.black),
            cursorColor: Colors.transparent,
            selectionColor: Colors.transparent,
            autofocus: false,
          ),
        ),
        Flexible(
          flex: 1,
          child: GridView.count(
            padding: EdgeInsets.only(left: 30.0, right: 30.0),
            crossAxisCount: 3,
            shrinkWrap: true,
            childAspectRatio: 1.95,
            children: List.generate(numbers.length, (index) {
              return new GridTile(
                child: new Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  elevation: 0.5,
                  color: Colors.grey,
                  child: new InkWell(
                    onTap: () {
                      if (_destination.text == "Enter phone number:") {
                        _destination.text = "";
                        this.setState(() {});
                      }

                      // TODO ::: fix cursor issue
                      _destination.text += numbers[index];
                    },
                    onLongPress: () {
                      if (numbers[index] == "0") {
                        _destination.text += "+";
                      }
                    },
                    child: new Center(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Text(
                            numbers[index],
                            style: TextStyle(fontSize: 22),
                          ),
                          new Text(
                            alpha[index],
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        new Padding(
          padding:
              EdgeInsets.only(left: 20.0, right: 20.0, top: 2.0, bottom: 45.0),
          child: new Row(
            children: <Widget>[
              new Expanded(
                // video call button
                child: new Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  elevation: 0.5,
                  color: Colors.white,
                  child: new InkWell(
                    radius: 50.0,
                    child: new Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.video_call,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              new Expanded(
                // voice call button
                child: new FloatingActionButton(
                  heroTag: "voice_call",
                  backgroundColor: Colors.green,
                  onPressed: () {
                    _handleCall(context);
                  },
                  tooltip: 'Dial',
                  mini: false,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  child: Icon(
                    Icons.phone,
                  ),
                ),
              ),
              new Expanded(
                // backspace button
                child: new Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  elevation: 0.5,
                  color: Colors.redAccent,
                  child: new InkWell(
                    radius: 50.0,
                    onTap: () => _handleBackSpace(),
                    onLongPress: () => _handleBackSpace(true),
                    child: new Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.backspace,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
