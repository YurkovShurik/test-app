import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:my_test_project/entity/car.dart';
import 'package:my_test_project/page/car_details_page.dart';

class CarCardForCars extends HookWidget {

  final Car car;

  const CarCardForCars({
    Key? key,
    required this.car,
    required Null Function() onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final isExpanded = useState(false);
    final carStatus = car.status == "On duty";

    return Card(
      elevation: 0,
      color: isExpanded.value ? Colors.white : const Color.fromRGBO(241, 245, 249, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: isExpanded.value ? const BorderSide(color: Colors.grey, width: 1) : BorderSide.none,
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
                            height: 20,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CarDetailsPage(car: car),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigoAccent.shade100,
                              ),
                              child: const Text('Details', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          if (carStatus) ...[
                            SizedBox(
                              height: 20,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.yellow.shade100,
                                ),
                                child: Text(car.status, style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
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