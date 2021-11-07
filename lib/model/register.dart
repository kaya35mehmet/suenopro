import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
// import 'dart:convert';
import 'package:crypto/crypto.dart';

String url = "https://www.instatistik.com";
String jsonUrl = url + "/apis/pro/signup.php";
Iterable res;

Future<String> register(String name, String surname, String phoneNumber,
    String username, String cityid, String gender, String password) async {
  String passwordmd5 = md5.convert(utf8.encode(password)).toString();

  final response = await http.post(jsonUrl, body: <String, String>{
    'name': name,
    'surname': surname,
    'gsm': phoneNumber,
    'username': username,
    'cityid': cityid,
    'gender': gender,
    'password': passwordmd5
  });

  if (response.statusCode == 200) {
    var res = json.decode(response.body);
    var reg = Register.fromJson(res);
   
    return "ok";
  } else {
    throw Exception('Failed');
  }
}

bool validateStructure(String value) {
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}

class Register {
  Widget navigateScreen;
  String username;
  String password;
  String name;
  String surname;
  String phoneNumber;
  String guid;
  Register(
      {this.username,
      this.navigateScreen,
      this.password,
      this.name,
      this.surname,
      this.phoneNumber,
      this.guid});

  factory Register.fromJson(Map json) {
    return Register(
      guid: json['guid'],
      // navigateScreen: MyHomePage(),
    );
  }
}
