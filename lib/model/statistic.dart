import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

String url = "https://www.instatistik.com";
String jsonUrlGet = url + "/apis/pro/statistic.php";

Future<Statistic> statistic() async {
  final storage = new FlutterSecureStorage();
  String _guid = await storage.read(key: "guid");
  final response = await http.post(jsonUrlGet, body: {'EmployeGuid': _guid});
  if (response.statusCode == 200) {
    Statistic statistic = new Statistic();
    var data = json.decode(response.body);
    statistic.withdrawn = Withdrawn.fromJson(data[3][0]);
    var star = Star.fromJson(data[2][0]);
    star.avarage = starcalc(star);
    statistic.star = star;
    statistic.favourites = Favourites.fromJson(data[1][0]);
    var sumcount = SumCount.fromJson(data[0][0]);
    statistic.sumCount = sumcount;
    return statistic;
  } else {
    throw Exception('Failed');
  }
}

class Statistic {

  Withdrawn withdrawn;
  SumCount sumCount;
  Star star;
  Favourites favourites;
  Statistic({
    this.star,
    this.favourites,
    this.withdrawn,
  });

  factory Statistic.fromJson(Map<String, dynamic> json) {
    return Statistic();
  }
}

class Star {
  String star1;
  String star2;
  String star3;
  String star4;
  String star5;
  String avarage;
  Star({
    this.star1,
    this.star2,
    this.star3,
    this.star4,
    this.star5,
    this.avarage,
  });

  factory Star.fromJson(Map json) {
    return Star(
      star1: json["star1"],
      star2: json["star2"],
      star3: json["star3"],
      star4: json["star4"],
      star5: json["star5"],
    );
  }
}

class Favourites {
  String favourites;
  Favourites({
    this.favourites,
  });

  factory Favourites.fromJson(Map json) {
    return Favourites(
      favourites: json["count(*)"],
    );
  }
}

class SumCount {
  String allbookings;
  String totalearned;
  String canceled;

  SumCount({
    this.allbookings,
    this.totalearned,
    this.canceled,

  });
  factory SumCount.fromJson(Map json) {
    return SumCount(
      allbookings: json["count(EmployeGuid)"],
      totalearned: json["SUM(price)"] ?? "0",
      canceled: json["SUM(cancel=1)"] ?? "0",
    );
  }
}

class Withdrawn{
  String withdrawn;
  Withdrawn({this.withdrawn});
  factory Withdrawn.fromJson(Map json) {
    return Withdrawn(
      withdrawn:json["SUM(money)"]
    );
  }
}

String starcalc(Star sta) {
  try {
    int star1 = int.parse(sta.star1);
    int star2 = int.parse(sta.star2);
    int star3 = int.parse(sta.star3);
    int star4 = int.parse(sta.star4);
    int star5 = int.parse(sta.star5);
    int sum1 =
        (star1 * 1) + (star2 * 2) + (star3 * 3) + (star4 * 4) + (star5 * 5);
    int sum2 = star1 + star2 + star3 + star4 + star5;
    int star = 0;
    if(sum1 == 0 || sum2 == 0)
      star = 0;
    else
      star = (sum1 / sum2).round();
    
    
    return star.toString();
  } catch (e) {
    return "0";
  }
}
