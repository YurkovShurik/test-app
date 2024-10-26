import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:my_test_project/entity/car.dart';
import 'package:my_test_project/page/car_details_page.dart';

class CarCardForCars extends HookWidget {

  final Car car;
  final GlobalKey<NavigatorState> navigatorKey;

  const CarCardForCars({
    Key? key,
    required this.car,
    required this.navigatorKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final carStatus = car.status == "On duty";

    return Card(
      elevation: 0,
      color: const Color.fromRGBO(241, 245, 249, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      car.images[0],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        car.model,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(
                            height: 25,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CarDetailsPage(car: car, navigatorKey: navigatorKey),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigoAccent,
                              ),
                              child: const Text('Details', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          if (carStatus) ...[
                            SizedBox(
                              height: 25,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.yellow.shade700,
                                ),
                                child: Text(car.status, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                          ]
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}