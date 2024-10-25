import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:my_test_project/component/car_card.dart';
import 'package:my_test_project/entity/car.dart';
import 'package:my_test_project/fetch/fetch_cars.dart';
import 'package:my_test_project/page/car_details_page.dart';

class StatusTab extends HookWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const StatusTab({Key? key, required this.navigatorKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const Text(
            'Car status',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Flexible(
            child: FutureBuilder<List<Car>>(
              future: fetchCars(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final cars = snapshot.data!;
                  return ListView.builder(
                    itemCount: cars.length,
                    itemBuilder: (context, index) {
                      return CarCard(
                        car: cars[index],
                        onPressed: () {
                          navigatorKey.currentState!.push(
                            MaterialPageRoute(
                              builder: (context) => CarDetailsPage(car: cars[index]),
                            ),
                          );
                        },
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('No cars available'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}