import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

String url = "https://www.instatistik.com";
String urljson = url + "/apis/forgotpassword.php";
String urljsonConfirm = url + "/apis/confcode.php";
String urljsonnewpass = url + "/apis/resetpassword.php";

Future<String> forgotpassword(String email) async {
  final response = await http.post(
    urljson,
    body: <String, String>{
      'eposta': email,
    },
  );

  if (response.statusCode == 200) {
    var dd = json.decode(response.body);
    return dd;
  } else {
    throw Exception('Failed');
  }
}

Future<String> confirmcode(String email, String code) async {
  final response = await http.post(
    urljsonConfirm,
    body: <String, String>{
      'eposta': email,
      'onaykodu': code,
    },
  );

  if (response.statusCode == 200) {
    var dd = json.decode(response.body);
    return dd;
  } else {
    throw Exception('Failed');
  }
}

Future<String> newpassword(String email, String password, String code) async {
   String passwordmd5 = md5.convert(utf8.encode(password)).toString();
  final response = await http.post(
    urljsonnewpass,
    body: <String, String>{
      'eposta': email,
      'sifre': passwordmd5,
      'onaykodu': code,
    },
  );

  if (response.statusCode == 200) {
    var dd = json.decode(response.body);
    return dd;
  } else {
    throw Exception('Failed');
  }
}
