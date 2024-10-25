import 'package:flutter/material.dart';
import 'package:my_test_project/entity/car.dart';

class CarDetailsPage extends StatelessWidget {
  final Car car;

  const CarDetailsPage({Key? key, required this.car}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Car Details',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              car.images[0],
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              car.model,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Type: ${car.type}'),
            Text('Capacity: ${car.capacity}'),
            Text('Steering: ${car.steering}'),
            if (car.gasoline != null) Text('Gasoline: ${car.gasoline}'),
            if (car.battery != null) Text('Battery: ${car.battery}'),
            const SizedBox(height: 16),
            Text(
              'Rents: ${car.rents}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              'Status: ${car.status}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (car.driver != null) ...[
              const Text('Driver Info', style: TextStyle(fontSize: 18)),
              Text('Name: ${car.driver?.name}'),
              Text('Phone: ${car.driver?.phone}'),
            ],
          ],
        ),
      ),
    );
  }
}