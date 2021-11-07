import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

String url = "https://www.instatistik.com";
String gethours = url + "/apis/pro/gethours.php";
String sethours = url + "/apis/pro/sethours.php";

List<List<Object>> days = [
  ["понедельник", 0, false],
  ["вторник", 1, false],
  ["среда", 2, false],
  ["Четверг", 3, false],
  ["Пятница", 4, false],
  ["Суббота", 5, false],
  ["Воскресенье", 6, false]
];

Future<List<List<Object>>> getdays() async {
  final storage = new FlutterSecureStorage();
  String _guid = await storage.read(key: "guid");
  final response = await http.post(gethours, body: {'EmployeGuid': _guid});
  if (response.statusCode == 200) {
    var res = json.decode(response.body);
    check(res);
    return days;
  } else {
    throw Exception('Failed');
  }
}

void check(dynamic list){
 
 for (var i = 0; i < days.length; i++) {
   if(list.contains(days[i][1])){
     days[i][2] = true;
   }
 }
 
}

Future<String> setdays(int dayid) async {
  final storage = new FlutterSecureStorage();
  String _guid = await storage.read(key: "guid");
  final response =
      await http.post(sethours, body: {'EmployeGuid': _guid, 'dayid': dayid.toString()});
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed');
  }
}

class Days {
  Days();

  factory Days.fromJson(Map<String, dynamic> json) {
    return Days();
  }
}
