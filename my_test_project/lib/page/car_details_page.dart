import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:my_test_project/entity/car.dart';

class CarDetailsPage extends HookWidget {

  final Car car;

  const CarDetailsPage({Key? key, required this.car}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final selectedImageIndex = useState(0);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 18),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    car.model,
                    style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        car.images[selectedImageIndex.value],
                        width: double.infinity,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: car.images.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              selectedImageIndex.value = index;
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedImageIndex.value == index ? Colors.indigoAccent : Colors.transparent,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  car.images[index],
                                  width: 100,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      elevation: 0,
                      color: const Color.fromRGBO(241, 245, 249, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              car.model,
                              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Row(
                                  children: [
                                    Icon(Icons.star, color: Colors.amber, size: 18),
                                    Icon(Icons.star, color: Colors.amber, size: 18),
                                    Icon(Icons.star, color: Colors.amber, size: 18),
                                    Icon(Icons.star, color: Colors.amber, size: 18),
                                    Icon(Icons.star_border, color: Colors.grey, size: 18),
                                  ],
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  car.rents,
                                  style: const TextStyle(color: Colors.blueGrey),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Table(
                              columnWidths: const {
                                0: FlexColumnWidth(2),
                                1: FlexColumnWidth(2),
                                2: FlexColumnWidth(1),
                                3: FlexColumnWidth(2),
                                4: FlexColumnWidth(2),
                              },
                              children: [
                                TableRow(
                                  children: [
                                    const Text('Type Car', style: TextStyle(color: Colors.blueGrey, fontSize: 14)),
                                    Text(
                                      car.type,
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(),
                                    const Text('Capacity', style: TextStyle(color: Colors.blueGrey, fontSize: 14)),
                                    Text(
                                      car.capacity,
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const TableRow(
                                  children: [
                                    SizedBox(height: 12),
                                    SizedBox(height: 12),
                                    SizedBox(height: 12),
                                    SizedBox(height: 12),
                                    SizedBox(height: 12),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    const Text('Steering', style: TextStyle(color: Colors.blueGrey, fontSize: 14)),
                                    Text(
                                      car.steering,
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(),
                                    const Text('Gasoline', style: TextStyle(color: Colors.blueGrey, fontSize: 14)),
                                    Text(
                                      car.gasoline!,
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: const Row(
                            children: [
                              Icon(Icons.history, size: 18, color: Colors.indigoAccent),
                              SizedBox(width: 2),
                              Text('Rent history', style: TextStyle(color: Colors.indigoAccent)),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Row(
                            children: [
                              Icon(Icons.apps, size: 18, color: Colors.indigoAccent),
                              SizedBox(width: 2),
                              Text('All cars', style: TextStyle(color: Colors.indigoAccent)),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}