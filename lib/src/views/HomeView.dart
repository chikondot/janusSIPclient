import 'package:flutter/material.dart';

import 'package:JanusSIPClient/src/utilities/ClientStorage.dart';
import 'package:JanusSIPClient/src/utilities/ClientStrings.dart';
import 'package:JanusSIPClient/src/utilities/ClientAssets.dart';
import 'widgets/noKBEt.dart';

class HomeViewWidget extends StatefulWidget {
  @override
  HomeViewWidgetState createState() => HomeViewWidgetState();
}

class HomeViewWidgetState extends State<HomeViewWidget> {
  final TextEditingController callDestinationField =
      new TextEditingController();

  String accountInformation = "";

  void initialViewInformation() async {
    accountInformation = (await Storage.getExistingString('contact'))!;
  }

  void persistViewInformation() async {
    Storage.setString('callDestination', callDestinationField.text);
  }

  bool isTextEmptyOrNull(String text) {
    return text.isEmpty ? true : false;
  }

  void screenStateUpdate(Function() callback) => this.setState(callback);

  void onBackspaceButtonPressedCallback([bool deleteAll = false]) async {
    return isTextEmptyOrNull(callDestinationField.text)
        ? null
        : screenStateUpdate(handleTextDeletion); // update to handle deleteAll
  }

  void handleTextDeletion() {
    String textInstance = callDestinationField.text;
    textInstance = textInstance.substring(0, textInstance.length - 1);
    callDestinationField.text = textInstance;
  }

  void onCallButtonPressedCallback() async {
    screenStateUpdate(() {});
    handlePageNavigation();
  }

  void handlePageNavigation([String destination = "/call"]) {
    Navigator.pushNamed(context, destination);
  }

  Future<void> showAlertDialog(String title, String content) {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$title'),
          content: Text('$content'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget showDrawerHeader() {
    if (isTextEmptyOrNull(accountInformation)) accountInformation = "Default";

    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Assets.primaryColor,
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 50.0,
            left: 16.0,
            child: new Icon(
              Icons.account_circle,
              size: 28.0,
              color: Assets.whiteColor,
            ),
          ),
          Positioned(
            bottom: 12.0,
            left: 16.0,
            child: Text(
              "$accountInformation",
              style: TextStyle(
                color: Assets.whiteColor,
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
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
            controller: callDestinationField,
            style: TextStyle(fontSize: 30.0, color: Assets.blackColor),
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
              void onTapAction() {
                callDestinationField.text += numbers[index];
              }

              void onLongPressAction() {
                if (numbers[index] == "0") callDestinationField.text += "+";
              }

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
                    onTap: onTapAction,
                    onLongPress: onLongPressAction,
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
                  color: Assets.whiteColor,
                  child: new InkWell(
                    radius: 50.0,
                    child: new Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.video_call,
                        color: Assets.whiteColor,
                      ),
                    ),
                  ),
                ),
              ),
              new Expanded(
                // voice call button
                child: new FloatingActionButton(
                  heroTag: "voice_call",
                  backgroundColor: Assets.greenColor,
                  onPressed: onCallButtonPressedCallback,
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
                  color: Assets.redColor,
                  child: new InkWell(
                    radius: 50.0,
                    onTap: () => onBackspaceButtonPressedCallback(),
                    onLongPress: () => onBackspaceButtonPressedCallback(true),
                    child: new Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.backspace,
                        color: Assets.whiteColor,
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

  /// *************************************************************
  /// *********** MAIN BUILD FUNCTION *****************************
  /// *************************************************************

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
      appBar: AppBar(
          title: Text(Strings.applicationName),
          backgroundColor: Assets.primaryColor,
          actions: <Widget>[]),
      body: SafeArea(child: dialPad(context)),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            showDrawerHeader(),
            SizedBox(
              height: 8.0,
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Assets.primaryColor,
              ),
              title: Text(
                'LogOut',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w300,
                  color: Assets.primaryColor,
                ),
              ),
              onTap: () {
                handlePageNavigation("/register");
              },
            ),
          ],
        ),
      ),
    );
  }
}
