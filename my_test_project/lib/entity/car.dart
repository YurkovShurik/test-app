import 'package:my_test_project/entity/driver.dart';

class Car {

  final String id;
  final String model;
  final String type;
  final String capacity;
  final String steering;
  final String? gasoline;
  final String? battery;
  final String rents;
  final String status;
  final int rating;
  final Driver? driver;
  final List<String> images;

  Car({
    required this.id,
    required this.model,
    required this.type,
    required this.capacity,
    required this.steering,
    this.gasoline,
    this.battery,
    required this.rents,
    required this.status,
    required this.rating,
    this.driver,
    required this.images,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      model: json['model'],
      type: json['type'],
      capacity: json['capacity'],
      steering: json['steering'],
      gasoline: json['gasoline'],
      battery: json['battery'],
      rents: json['rents'],
      status: json['status'],
      rating: json['rating'],
      driver: json['driver'] != null ? Driver.fromJson(json['driver']) : null,
      images: List<String>.from(json['images']),
    );
  }
}