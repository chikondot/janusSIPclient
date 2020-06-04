// information
import 'package:janus_sip_client/src/information/dealer.dart';

// communication
import 'protos/payments.pbgrpc.dart';
import 'protos/users.pbgrpc.dart';
import 'package:grpc/grpc.dart';

// define channel of communication to GRPC server to connect
final channel = ClientChannel(
  "momari.ai.co.zw",
  port: 50000,
  options: ChannelOptions(
    userAgent: "guroo-application",
    connectionTimeout: Duration(
      seconds: 180,
    ),
    credentials: ChannelCredentials.insecure(),
  ),
);

// Class definition
class GRPCServer {
  // define entitiies
  User user = new User();
  Payment payment = new Payment();

  // init server communication for each stub connection
  final userClient = userServiceClient(channel);
  final paymentClient = payServiceClient(channel);

  // **************************************************
  // ******* USER STUB REGISTRATION SECTION ***********
  // **************************************************

  // create user information from client for access to auth user
  Future<detailsUser> sendUserLogin(String username, String password) async {
    try {
      return userClient.loginUser(loginUser()
        ..username = username
        ..domain = "${Dealer.domain}"
        ..password = password);
    } catch (e) {
      print("**********************************************");
      print("DEBUG ::: USER LOGIN (SERVER EXCEPTION) >>> $e");
      print("**********************************************");

      return null;
    }
  }

  // create user information from client for generation of sms to create user
  Future sendUserVerification(String contact) async {
    try {
      return userClient.verifyUser(verifyUser()..contact = contact);
    } catch (e) {
      print("****************************************************");
      print("DEBUG ::: SMS VERIFICATION (SERVER EXCEPTION) >>> $e");
      print("****************************************************");

      return null;
    }
  }

  // create user information from client for generation of user entity
  Future sendUserCreate(
      String contact, String password, String verification) async {
    try {
      // user information definition
      user
        ..contact = contact
        ..password = password
        ..domain = "${Dealer.domain}"
        ..verification = verification;

      return userClient.createUser(createUser()..user = user);
    } catch (e) {
      print("*************************************************");
      print("DEBUG ::: USER REGISTER (SERVER EXCEPTION) >>> $e");
      print("*************************************************");

      return null;
    }
  }

  // **************************************************
  // ******* USER STUB OPERATIONS SECTION *************
  // **************************************************

  Future<Account> sendUserBalance(String contact) async {
    try {
      return userClient.getBalance(infoUser()
        ..username = contact
        ..domain = "${Dealer.domain}");
    } catch (e) {
      print("*************************************************");
      print("DEBUG ::: USER REGISTER (SERVER EXCEPTION) >>> $e");
      print("*************************************************");

      return null;
    }
  }

  // **************************************************
  // ***** PAYMENT STUB REGISTRATION SECTION **********
  // **************************************************

  // send request to return nonce to init paypal payment
  Future<detailsPayment> getPayPalNonce() async {
    try {
      return paymentClient
          .getPayPalToken(detailsPayment()..result = "${Dealer.domain}");
    } catch (e) {
      print("*****************************************************************");
      print(
          "DEBUG ::: PAYPAL TOKEN PROCESSING PAYMENT (SERVER EXCEPTION) >>> $e");
      print("*****************************************************************");

      return null;
    }
  }

  // send payment information to server after processing
  Future<detailsPayment> sendPayPalPayment(
      String contact, double amount, String nonce) async {
    try {
      // define payment information (user + amount)
      payment
        ..contact = contact
        ..amount = amount
        ..domain = "${Dealer.domain}"
        ..currency = "USD"
        ..method = PaymentMethod.PAYPAL;

      return paymentClient.makePayPalPayment(paymentRequest()
        ..payment = payment
        ..nonce = nonce);
    } catch (e) {
      print("**********************************************************");
      print("DEBUG ::: PAYPAL PAYMENT REQUEST (SERVER EXCEPTION) >>> $e");
      print("**********************************************************");

      return null;
    }
  }
}
