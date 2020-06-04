// communication
import 'package:dio/dio.dart';

// information
import 'package:janus_sip_client/src/information/dealer.dart';

// handle generic structure and information of request
class HTTPServer {
  static BaseOptions options = new BaseOptions(
    baseUrl: "https://api.durihub.co.zw:8081",
    connectTimeout: 5000,
    contentType: "application/x-www-form-urlencoded",
  );

  static Dio dio = new Dio(options);

  // operation to get token for auth of server requests
  Future<Response> getToken() async {
    try {
      return await dio.post(
        "/v2/Token",
        data: {"Username": "silence", "Password": "silence"},
        options: new Options(contentType: "application/x-www-form-urlencoded"),
      );
    } catch (e) {
      print("**************************************************");
      print("DEBUG ::: HTTP GET TOKEN (SERVER EXCEPTION) >>> $e");
      print("**************************************************");

      return null;
    }
  }

  // operation to get user balance from server
  Future<Response> getBalance(String contact) async {
    try {
      return await dio.post(
        "/ocsBalance",
        data: {"Account": contact, "Tenant": "${Dealer.domain}"},
        options: new Options(contentType: "application/x-www-form-urlencoded"),
      );
    } catch (e) {
      print("****************************************************");
      print("DEBUG ::: HTTP GET BALANCE (SERVER EXCEPTION) >>> $e");
      print("****************************************************");

      return null;
    }
  }

  // operation to process payment via voucher
  // operation to get user balance from server
  Future<Response> payVocuher(String contact, amount) async {
    try {
      return await dio.post(
        "/voucherRecharge",
        data: {"Phone": contact, "Tenant": "${Dealer.domain}", "Pin": amount},
        options: new Options(contentType: "application/x-www-form-urlencoded"),
      );
    } catch (e) {
      print("*******************************************************");
      print("DEBUG ::: HTTP REDEEM VOUCHER (SERVER EXCEPTION) >>> $e");
      print("*******************************************************");

      return null;
    }
  }
}
