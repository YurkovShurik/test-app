class Driver {

  final String name;
  final String phone;

  Driver({
    required this.name,
    required this.phone,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      name: json['name'],
      phone: json['phone'],
    );
  }
}