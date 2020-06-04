import 'dart:io';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';

import 'package:contacts_service/contacts_service.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:janus_sip_client/src/communication/grpc.dart';
import 'package:janus_sip_client/src/information/dealer.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'account.dart';
import 'widgets/groovinex.dart';
import 'widgets/noKBEt.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  int currentPage = 0;
  GlobalKey bottomNavigationKey = GlobalKey();
  Iterable<Contact> _contacts;
  Iterable<Contact> _contactsTemp;
  TextEditingController _destinationNumber = new TextEditingController();
  TextEditingController _searchContact = new TextEditingController();

  // variable definitions
  String _destination;
  String _username;
  double _balance;
  GRPCServer server = new GRPCServer();
  SharedPreferences _preferences;

  void _loadSettings() async {
    _preferences = await SharedPreferences.getInstance();
    _username = _preferences.getString("contact");
    _destination = _preferences.getString('dest') ?? 'Enter phone number:';
    _destinationNumber = TextEditingController(text: _destination);
    _destinationNumber.text = _destination;
    this.setState(() {});
  }

  // get users balance and display
  _getBalance() async {
    // user information and request
    final response =
        await server.sendUserBalance(_preferences.getString("contact"));

    if (response == null) {
      // send user status update onError
      FlushbarHelper.createError(
        title: "note:",
        message: "Failed to get user balance.",
        duration: Duration(seconds: 3),
      )..show(context);
      return;
    } else {
      // set balance to be displayed to user
      if (mounted)
        this.setState(() {
          _balance = response.balance;
        });
    }
  }

  Widget _handleCall(BuildContext context, [bool voiceonly = false]) {
    var dest = _destinationNumber.text;
    if (dest == null || dest.isEmpty) {
      showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Target is empty.'),
            content: Text('Please enter a number to dail!'),
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
      return null;
    }
    _preferences.setString('dest', dest);
    Navigator.pushNamed(context, '/call');
    return null;
  }

  void _handleBackSpace([bool deleteAll = false]) {
    var text = _destinationNumber.text;
    if (text.isNotEmpty) {
      this.setState(() {
        text = deleteAll ? '' : text.substring(0, text.length - 1);
        _destinationNumber.text = text;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadSettings();
    _init();
  }

  void _init() async {
    await refreshContacts();
    await _getBalance();
  }

  refreshContacts() async {
    var contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts.where((i) => i.phones.length > 0);
    });
    _contactsTemp = _contacts;
  }

  onSearchTextChanged(String text) async {
    _contacts = _contactsTemp;
    if (text.isEmpty) {
      this.setState(() {});
      return;
    }

    this.setState(() {
      _contacts = Platform.isIOS
          ? _contacts.where((i) =>
              i.phones.length > 0 &&
              i.givenName.toLowerCase().contains(text.toLowerCase()))
          : _contacts.where((i) =>
              i.phones.length > 0 &&
              i.displayName.toLowerCase().contains(text.toLowerCase()));
    });
  }

  Widget call(BuildContext context) {
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
            controller: _destinationNumber,
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
                  color: Dealer.secColor,
                  child: new InkWell(
                    onTap: () {
                      print("tapped");
                      if (_destinationNumber.text == "Enter phone number:")
                        _destinationNumber.text = "";
                      _destinationNumber.text += numbers[index];
                    },
                    onLongPress: () {
                      if (numbers[index] == "0") {
                        _destinationNumber.text += "+";
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
                  onPressed: () => _handleCall(context, true),
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
                  color: Dealer.mainColor,
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

  Widget contacts(BuildContext context) {
    this.setState(() {});
    return _contacts == null
        ? Center(child: CircularProgressIndicator())
        : _contactsTemp.length == 0
            ? Center(child: Text("No contacts"))
            : new Column(
                children: <Widget>[
                  new Container(
                    color: Dealer.mainColor,
                    child: new Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: new Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: new ListTile(
                          leading: new Icon(Icons.search),
                          title: new TextField(
                            controller: _searchContact,
                            decoration: new InputDecoration(
                                hintText: 'Search', border: InputBorder.none),
                            onChanged: onSearchTextChanged,
                          ),
                          trailing: new IconButton(
                            icon: new Icon(Icons.cancel),
                            onPressed: () {
                              _searchContact.clear();
                              onSearchTextChanged('');
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  new Expanded(
                    child: ListView.builder(
                      itemCount: _contacts?.length ?? 0,
                      itemBuilder: (context, index) {
                        Contact c = _contacts?.elementAt(index);
                        bool isExpanded = false;

                        var name = "";
                        if (Platform.isAndroid) {
                          // Android-specific code
                          name = c.displayName;
                        } else if (Platform.isIOS) {
                          // iOS-specific code
                          name = c.givenName;
                        }
                        print(_contacts.length.toString() +
                            "  -   " +
                            name +
                            "  -  " +
                            index.toString());

                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 5.0),
                          child: Material(
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            child: GroovinExpansionTile(
                              defaultTrailingIconColor: Dealer.mainColor,
                              leading: CircleAvatar(
                                backgroundColor: Dealer.mainColor,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                              title: Text(
                                name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                              onExpansionChanged: (value) {
                                setState(() {
                                  isExpanded = value;
                                });
                              },
                              inkwellRadius: !isExpanded
                                  ? BorderRadius.all(Radius.circular(8.0))
                                  : BorderRadius.only(
                                      topRight: Radius.circular(8.0),
                                      topLeft: Radius.circular(8.0),
                                    ),
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5.0),
                                    bottomRight: Radius.circular(5.0),
                                  ),
                                  child: Column(
                                    children: c.phones
                                        .map(
                                          (i) => Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5.0,
                                                left: 70.0,
                                                right: 30.0,
                                                bottom: 10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  i.value ?? "",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                ),
                                                IconButton(
                                                  splashColor: Dealer.mainColor,
                                                  icon: Icon(
                                                    Icons.phone,
                                                    color: Dealer.mainColor,
                                                  ),
                                                  onPressed: () {
                                                    _destinationNumber.text =
                                                        i.value;
                                                    _handleCall(context, true);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
  }

  // header to display on Drawer menu
  Widget _drawerHeader() {
    if (mounted) this.setState(() {});
    if (_username == null) _username = "Please sign in";
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Dealer.mainColor,
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
              "$_username",
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

  @override
  Widget build(BuildContext context) {
    if (_balance == null) _balance = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    child: Text(
                      "Balance: \$$_balance",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      // get new account information
                      _getBalance();
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: SafeArea(
          child: _getPage(currentPage),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 10.0),
        child: FancyBottomNavigation(
          tabs: [
            TabData(
                iconData: Icons.dialpad,
                title: "Call",
                onclick: () {
                  final FancyBottomNavigationState fState =
                      bottomNavigationKey.currentState;
                  fState.setPage(0);
                }),
            TabData(
                iconData: Icons.history,
                title: "History",
                onclick: () {
                  final FancyBottomNavigationState fState =
                      bottomNavigationKey.currentState;
                  fState.setPage(1);
                }),
            TabData(
                iconData: Icons.contacts,
                title: "Contacts",
                onclick: () {
                  final FancyBottomNavigationState fState =
                      bottomNavigationKey.currentState;
                  fState.setPage(2);
                }),
            TabData(
                iconData: Icons.account_box,
                title: "Account",
                onclick: () {
                  final FancyBottomNavigationState fState =
                      bottomNavigationKey.currentState;
                  fState.setPage(3);
                })
          ],
          initialSelection: 0,
          key: bottomNavigationKey,
          onTabChangedListener: (position) {
            setState(() {
              currentPage = position;
            });
          },
        ),
      ),
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
                color: Dealer.mainColor,
              ),
              title: Text(
                'Recharge',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w300,
                    color: Dealer.mainColor),
              ),
              onTap: () => Navigator.pushNamed(context, '/account/recharge'),
            ),
            ListTile(
              leading: Icon(
                Icons.account_balance_wallet,
                color: Dealer.mainColor,
              ),
              title: Text(
                'About',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w300,
                    color: Dealer.mainColor),
              ),
              onTap: () => Navigator.pushNamed(context, '/account/about'),
            ),
          ],
        ),
      ),
    );
  }

  // operation to dictate page currently shown to user
  _getPage(int page) {
    switch (page) {
      case 0:
        // main page with phone dialer
        return call(context);
      case 1:
      // call history page with call logs
      case 2:
        // contact page to show system contacts
        return contacts(context);
      case 3:
        // account page for platform services
        return AccountsWidget();
      default:
        // failed to match return empty page
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("---"),
              RaisedButton(
                child: Text(
                  "Ooops..\n I will fix this!",
                  style: TextStyle(color: Colors.white),
                ),
                color: Theme.of(context).primaryColor,
                onPressed: () {},
              )
            ],
          ),
        );
    }
  }
}
