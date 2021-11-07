import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:massageapppro/home_screen.dart';
import 'package:crypto/crypto.dart';

String url = "https://www.instatistik.com";
String jsonUrl = url + "/apis/pro/login.php";
String jsonUrlCheck = url + "/apis/pro/usercheck.php";
Iterable res;
FirebaseMessaging fcm = FirebaseMessaging();

Future<Login> login(String username, String password) async {
  String deviceid = await fcm.getToken();
  String passwordmd5 = md5.convert(utf8.encode(password)).toString();
  final response = await http.post(jsonUrl, body: <String, String>{
    'username': username,
    'password': passwordmd5,
    'deviceid': deviceid,
  });

  if (response.statusCode == 200) {
    var res = json.decode(response.body);
    var login = Login.fromJson(res);
    if (login.guid != "error") {
      final storage = new FlutterSecureStorage();
      await storage.write(key: "guid", value: login.guid);
    }

    return login;
  } else {
    throw Exception('Failed');
  }
}

Future<Login> usercheck(String guid) async {
  final response = await http.post(jsonUrlCheck, body: {'guid': guid});

  if (response.statusCode == 200) {
    var res = json.decode(response.body);
    var reg = Login.fromJson(res);
    return reg;
  } else {
    throw Exception('Failed');
  }
}

class Login {
  Widget navigateScreen;
  String guid;
  int onay;
  int isprofilefull;
  Login({
    this.guid,
    this.navigateScreen,
    this.onay,
    this.isprofilefull,
  });

  factory Login.fromJson(Map json) {
    return Login(
      guid: json["guid"],
      onay: int.parse(json["onay"].toString()),
      isprofilefull: int.parse(json["isprofilefull"].toString()),
      navigateScreen: HomePage(),
    );
  }
}
