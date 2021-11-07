import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

String url = "https://www.instatistik.com";
String skills = url + "/apis/pro/getskills.php";
String addskill = url + "/apis/pro/addskills.php";

Future<List<Skills>> getskills() async {
  final storage = new FlutterSecureStorage();
  String _guid = await storage.read(key: "guid");
  final response = await http.post(skills, body: {'EmployeGuid': _guid});
  if (response.statusCode == 200) {
    Iterable res = json.decode(response.body);
    return res.map((e) => Skills.fromJson(e)).toList();
  } else {
    throw Exception('Failed');
  }
}

Future<String> addskills(String massageTypeGuid, String price) async {
  final storage = new FlutterSecureStorage();
  String _guid = await storage.read(key: "guid");
  final response = await http.post(addskill, body: {'employeeGuid': _guid,'massageTypeGuid': massageTypeGuid, "perHourFee":price});
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed');
  }
}

class Skills {
  String serviceName;
  String massageName;
  String guid;
  String description;
  int durum;
  String perHourFee;
  Skills({
    this.serviceName,
    this.massageName,
    this.guid,
    this.description,
    this.durum,
    this.perHourFee,
  });

  factory Skills.fromJson(Map<String, dynamic> json) {
    return Skills(
      serviceName: json["serviceName"],
      massageName: json["massagename"],
      guid: json["guid"],
      perHourFee: json["perHourFee"] ,
      // description: json["description"],
      durum: int.parse(json['durum'])
    );
  }
}
