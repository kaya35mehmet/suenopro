import 'dart:convert';
import 'package:http/http.dart' as http;

String url = "https://www.instatistik.com";
String jsonUrl = url + "/apis/getcities.php";

Future<List<Cities>> getcities() async {
  final response = await http.get(jsonUrl);

  if (response.statusCode == 200) {
    Iterable res = json.decode(response.body);
    return res.map((e) => Cities.fromJson(e)).toList();
  } else {
    throw Exception('Failed');
  }
}

class Cities {
  String id;
  String name;

  Cities({
    this.id,
    this.name,
  });

  factory Cities.fromJson(Map<String, dynamic> json) {
    return Cities(
      id: json['Id'],
      name: json['CityName'],
    );
  }
}
