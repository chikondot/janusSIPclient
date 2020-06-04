import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:janus_sip_client/src/communication/grpc.dart';
import 'package:janus_sip_client/src/communication/protos/payments.pbgrpc.dart';
import 'package:janus_sip_client/src/information/dealer.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AccountsWidget extends StatefulWidget {
  @override
  AccountsWidgetState createState() => AccountsWidgetState();
}

class AccountsWidgetState extends State<AccountsWidget> {
  // variable definition
  Size deviceSize;
  double _balance;
  String _username;
  String _token;
  TextEditingController _amountController = new TextEditingController();
  SharedPreferences _preferences;

  // define Account
  GRPCServer server = new GRPCServer();

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

  // get generated paypal token from server to paypal
  Future getToken() async {
    detailsPayment response = await server.getPayPalNonce();

    // check if error or response
    if (response == null) {
      // failed to connect and get nonce from server
      FlushbarHelper.createError(
          message: "Please make sure you are connected to the Internet.",
          duration: Duration(seconds: 3))
        ..show(context);
      return;
    }

    print("DEBUG : GOT PAYPAL NONCE FROM SERVER >>> ${response.result}");
    if (mounted)
      this.setState(() {
        _token = response.result;
      });
    return response.result;
  }

  // send topup request to paypal for crediting
  Future topupAccount(String token, String amount) async {
    try {
      // get nonce from braintree and send to paypal server
      BraintreeDropInRequest request = BraintreeDropInRequest(
        clientToken: token,
        collectDeviceData: true,
        googlePaymentRequest: BraintreeGooglePaymentRequest(
          totalPrice: amount,
          currencyCode: 'USD',
          billingAddressRequired: false,
        ),
        paypalRequest: BraintreePayPalRequest(
          amount: amount,
          displayName: "maswerasei",
        ),
      );

      // show drop-in menu to user
      BraintreeDropInResult result = await BraintreeDropIn.start(request);

      // get payment nonce and perform payment
      if (result != null) {
        print("DEBUG : ENTIRE NONCE BODY HAS >>> ${result.paymentMethodNonce}");
        print("DEBUG : NONCE RECEIVED >>> ${result.paymentMethodNonce.nonce}");

        // handle order to paypal
        detailsPayment response = await server.sendPayPalPayment(
            _preferences.getString("contact"),
            double.parse(amount),
            result.paymentMethodNonce.nonce);

        // check if error or response
        if (response == null) {
          // failed to connect and get nonce from server
          FlushbarHelper.createError(
              message: "Please make sure you are connected to the Internet.",
              duration: Duration(seconds: 3))
            ..show(context);

          return;
        } else {
          print("DEBUG : RESPONSE FROM PAYMENT >>>> ${response.result}");

          // failed to connect and get nonce from server
          FlushbarHelper.createSuccess(
              title: "success: ",
              message: "Recharge successful",
              duration: Duration(seconds: 3))
            ..show(context);

          return;
        }
      } else {
        print('DEBUG : SELECTION WAS CANCELLED!');
        return;
      }

      // exception handling catching all errors
    } catch (e) {
      print("DEBUG : PAYPAL ERROR PERFORMING REQUEST >>> ${e.message}");
      FlushbarHelper.createError(
          title: "payment failed: ",
          message: "reason : ${e.message}",
          duration: Duration(seconds: 3))
        ..show(context);
      return;
    }
  }

  // CONFIRM LOGOUT FROM APPLICATION
  _neverSatisfied() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Note'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You are about to log out. Continue?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('YES, LOGOUT'),
              onPressed: () {
                // remove all information set during process
                _preferences.clear();
                _username = null;
                _balance = null;
                _token = null;
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                if (mounted) this.setState(() {});

                Navigator.pushNamed(context, "/home");
              },
            ),
          ],
        );
      },
    );
  }

  Widget profileHeader() => Container(
        height: deviceSize.height / 4,
        width: double.infinity,
        color: Dealer.mainColor,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            shape: RoundedRectangleBorder(),
            elevation: 0.0,
            clipBehavior: Clip.antiAlias,
            color: Dealer.mainColor,
            child: FittedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        border: Border.all(width: 2.0, color: Colors.white)),
                    child: CircleAvatar(
                      radius: 40.0,
                      backgroundImage: AssetImage('images/avatar.png'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      _username,
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget balanceDisplay() => Container(
        height: deviceSize.height / 3.5,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 1.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  child: Container(
                height: 80.0,
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: new Center(
                                child: new Container(
                                  margin: EdgeInsets.all(10.0),
                                  child: new Icon(
                                    Icons.account_balance_wallet,
                                    color: Dealer.mainColor,
                                    size: 30.0,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2.0),
                                child: Column(
                                  children: <Widget>[
                                    GestureDetector(
                                        child: Text(
                                          _balance == null
                                              ? "not currently signed in"
                                              : 'USD\$' +
                                                  _balance.toStringAsFixed(2),
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black),
                                        ),
                                        onTap: () async {
                                          await _getBalance();
                                          if (mounted) this.setState(() {});
                                        })
                                  ],
                                )),
                            GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: Text(
                                        'Top up Account',
                                        style: TextStyle(
                                            fontSize: 17.0,
                                            color: Dealer.mainColor),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 1.0),
                                      child: Icon(
                                        Icons.keyboard_arrow_right,
                                        color: Dealer.mainColor,
                                        size: 30.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                paymentAmount();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      );

  Widget thistory(Widget icon, String title) => Container(
        height: deviceSize.height / 13,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Container(
            height: 80.0,
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            child: Card(
              shape: RoundedRectangleBorder(),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: icon,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        title,
                        style: TextStyle(fontSize: 18.0),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  // data page shown to Prefs.User == ("guest", "customer")
  Widget bodyData() => SingleChildScrollView(
        child: Column(
          children: <Widget>[
            profileHeader(),
            balanceDisplay(),
            GestureDetector(
              child: thistory(
                  Icon(
                    Icons.beach_access,
                    color: Dealer.mainColor,
                    size: 20.0,
                  ),
                  "Recharge History"),
              onTap: () {},
            ),
            _username == "" || _username == null
                ? GestureDetector(
                    child: thistory(
                        Icon(
                          Icons.beach_access,
                          color: Dealer.mainColor,
                          size: 18.0,
                        ),
                        "Sign In?"),
                    onTap: () {
                      Navigator.pushNamed(context, "/register");
                    },
                  )
                : GestureDetector(
                    child: thistory(
                        Icon(
                          Icons.beach_access,
                          color: Colors.red,
                          size: 18.0,
                        ),
                        "Log out"),
                    onTap: () {
                      _neverSatisfied();
                    },
                  ),
          ],
        ),
      );

  // show dialog for input of amount to top up account
  paymentAmount() => showDialog(
        context: context,
        builder: (BuildContext context) => new AlertDialog(
          title: new Text('Enter amount'),
          content: new TextField(
            controller: _amountController,
            maxLines: 1,
            decoration: InputDecoration(
              hintText: "e.g. 10",
              labelText: "Amount",
            ),
            keyboardType: TextInputType.number,
          ),
          actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: new Text('CANCEL')),
            new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  paymentOptions();
                },
                child: new Text('TOP UP')),
          ],
        ),
      );

  // show topup options to user for selection
  paymentOptions() => showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new ListTile(
              leading: Image(
                image: AssetImage('images/recharge/stripe.png'),
                fit: BoxFit.contain,
                height: 50,
                width: 50,
              ),
              title: Text(
                "Stripe",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Dealer.mainColor,
                    fontSize: 18.0),
              ),
              onTap: () {
                // Navigator.pushNamed(context, "/account/recharge/stripe");
              },
            ),
            new ListTile(
              leading: Image(
                image: AssetImage('images/recharge/paypal.png'),
                fit: BoxFit.contain,
                height: 50,
                width: 50,
              ),
              title: Text(
                "PayPal",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Dealer.mainColor,
                    fontSize: 18.0),
              ),
              onTap: () async {
                String token = await getToken();
                await topupAccount(token, _amountController.text);
                if (mounted) this.setState(() {});
              },
            ),
          ],
        );
      });

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() async {
    _preferences = await SharedPreferences.getInstance();
    _username = _preferences.getString("contact");
    await _getBalance();
    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    if (_username == null) _username = "Please sign in";
    return bodyData();
  }
}
