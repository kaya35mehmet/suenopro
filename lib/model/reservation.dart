import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

String url = "https://www.instatistik.com";
String jsonUrlGet = url + "/apis/pro/upcoming.php";
String jsonUrlPast = url + "/apis/pro/past.php";

Future<List<Reservations>> upcomingReservations() async {
  final storage = new FlutterSecureStorage();
  String _guid = await storage.read(key: "guid");
  final response = await http.post(jsonUrlGet, body: {'EmployeGuid': _guid});
  if (response.statusCode == 200) {
    Iterable res = json.decode(response.body);
    return res.map((e) => Reservations.fromJson(e)).toList();
  } else {
    throw Exception('Failed');
  }
}

Future<List<Reservations>> pastReservations() async {
  final storage = new FlutterSecureStorage();
  String _guid = await storage.read(key: "guid");
  final response = await http.post(jsonUrlPast, body: {'EmployeGuid': _guid});
  if (response.statusCode == 200) {
    Iterable res = json.decode(response.body);
    return res.map((e) => Reservations.fromJson(e)).toList();
  } else {
    throw Exception('Failed');
  }
}

class Reservations {
  Widget navigateScreen;
  String usersGuid;
  String date;
  String hour;
  String length;
  String userNameSurname;
  String addressname;
  String photo;
  String phoneNumber;
  String lanLat;

  Reservations({
    this.usersGuid,
    this.date,
    this.hour,
    this.navigateScreen,
    this.length,
    this.userNameSurname,
    this.addressname,
    this.photo,
    this.phoneNumber,
    this.lanLat
  });

  factory Reservations.fromJson(Map<String, dynamic> json) {
    return Reservations(
      usersGuid: json['userGuid'],
      date: json['date'],
      hour: json['hours'],
      length: json['length'],
      userNameSurname: json['name'] + " " + json["surname"],
      addressname: json['Adres'],
      phoneNumber: json['gsm'],
      lanLat: json['LanLat'],
      // photo: url + "/employePhotos/" + json["photo"],
    );
  }
}
