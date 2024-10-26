import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_test_project/entity/car.dart';

Future<List<Car>> fetchCars() async {

  const url = 'https://drive.google.com/uc?export=download&id=1HBZlv1ZrZeMUoWpeSN9fk3pcmZQKIf5u';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    final List<dynamic> carsJson = jsonData['cars'];
    return carsJson.map((json) => Car.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load cars');
  }
}