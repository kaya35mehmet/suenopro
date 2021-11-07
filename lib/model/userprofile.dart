import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

String url = "https://www.instatistik.com";
String jsonUrl = url + "/apis/pro/getprofile.php";
String jsonUrlEdit = url + "/apis/pro/editprofile.php";
String jsonUrlChangePass = url + "/apis/pro/changepassword.php";
String imageupload = url + "/apis/pro/imageupload.php";
String responsewithdrawn = url + "/apis/pro/withdrawnresponse.php";
String workhour = url + "/apis/pro/workhours.php";
final storage = new FlutterSecureStorage();

Future<EmployeeProfile> getuser() async {
  String userguid = await storage.read(key: "guid");

  final response = await http.post(jsonUrl, body: {'userguid': userguid});

  if (response.statusCode == 200) {
    var res = json.decode(response.body);
    var reg = EmployeeProfile.fromJson(res);
    return reg;
  } else {
    throw Exception('Failed');
  }
}

Future<String> upload(File file) async {
  String guid = await storage.read(key: "guid");
  var request = http.MultipartRequest("POST", Uri.parse(imageupload));
  var pic = await http.MultipartFile.fromPath("file", file.path);
  request.files.add(pic);
  request.fields["guid"] = guid;
  var response = await request.send();
  var responseData = await response.stream.toBytes();
  var responseString = String.fromCharCodes(responseData);

  return json.decode(responseString);
}

Future<String> withdrawnresponse() async {
  String guid = await storage.read(key: "guid");
  final response = await http.post(
    responsewithdrawn,
    body: <String, String>{
      'guid': guid,
      'date': DateTime.now().toString(),
    },
  );
  if (response.statusCode == 200) {
    var res = json.decode(response.body);
    return res;
  } else {
    throw Exception('Failed');
  }
}

Future<String> editprofile(String name, String surname, String username,
    String gsm, String address, String about, String cityId) async {
  String guid = await storage.read(key: "guid");
  final response = await http.post(
    jsonUrlEdit,
    body: <String, String>{
      'guid': guid,
      'name': name,
      'surname': surname,
      'username': username,
      'gsm': gsm,
      'address': address,
      'about': about,
      'cityId': cityId,
    },
  );
  if (response.statusCode == 200) {
    var res = json.decode(response.body);
    return res;
  } else {
    throw Exception('Failed');
  }
}

Future<String> changepassword(String oldpass, String newpass) async {
  String guid = await storage.read(key: "guid");
  final response = await http.post(
    jsonUrlChangePass,
    body: <String, String>{
      'guid': guid,
      'oldpass': oldpass,
      'newpass': newpass,
    },
  );
  if (response.statusCode == 200) {
    var res = json.decode(response.body);
    return res;
  } else {
    throw Exception('Failed');
  }
}

Future<String> workhours(String val) async {
  String guid = await storage.read(key: "guid");
  final response = await http.post(
    workhour,
    body: <String, String>{
      'guid': guid,
      'workhours': val,
    },
  );
  if (response.statusCode == 200) {
    var res = json.decode(response.body);
    return res;
  } else {
    throw Exception('Failed');
  }
}

class EmployeeProfile {
  Widget navigateScreen;
  String username;
  String password;
  String name;
  String surname;
  String phoneNumber;
  String guid;
  String address;
  String about;
  String photo;
  String gender;
  String createdDate;
  String cityid;
  String cityName;
  int active;
  String workhours;

  EmployeeProfile({
    this.navigateScreen,
    this.username,
    this.password,
    this.name,
    this.surname,
    this.about,
    this.phoneNumber,
    this.guid,
    this.address,
    this.photo,
    this.gender,
    this.createdDate,
    this.cityid,
    this.cityName,
    this.active,
    this.workhours,
  });

  factory EmployeeProfile.fromJson(Map json) {
    return EmployeeProfile(
      guid: json['guid'],
      username: json['username'],
      name: json['name'],
      surname: json['surname'],
      phoneNumber: json['gsm'],
      address: json["address"],
      photo: json["photo"] == ''
          ? url + "/employePhotos/blank.jpg"
          : url + "/employePhotos/" + json["photo"],
      gender: json["gender"],
      createdDate: json["createDate"],
      about: json["about"],
      cityid: json["cityId"],
      cityName: json["CityName"],
      workhours: json["workhours"],
      active: int.parse(json["active"]),
    );
  }
}

int starcalc(star1, star2, star3, star4, star5) {
  try {
    int sum1 =
        (star1 * 1) + (star2 * 2) + (star3 * 3) + (star4 * 4) + (star5 * 5);
    int sum2 = star1 + star2 + star3 + star4 + star5;
    int star = (sum1 / sum2).round();
    return star;
  } catch (e) {
    return 0;
  }
}

int reviewcalc(star1, star2, star3, star4, star5) {
  return star1 + star2 + star3 + star4 + star5;
}

pointcalc(star1, star2, star3, star4, star5) {
  int sum1 =
      (star1 * 1) + (star2 * 2) + (star3 * 3) + (star4 * 4) + (star5 * 5);
  int sum2 = star1 + star2 + star3 + star4 + star5;
  double point = (sum1 / sum2);
  return point.toString().substring(0, 3);
}
