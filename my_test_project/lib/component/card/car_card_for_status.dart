import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:my_test_project/entity/car.dart';
import 'package:my_test_project/page/car_details_page.dart';

class CarCardForStatus extends HookWidget {

  final Car car;
  final GlobalKey<NavigatorState> navigatorKey;

  const CarCardForStatus({
    Key? key,
    required this.car,
    required this.navigatorKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final isExpanded = useState(false);

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isExpanded.value) ...[
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
                        Row(
                          children: [
                            Text(
                              car.id,
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              car.model,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          car.driver?.phone ?? 'N/A',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      isExpanded.value = !isExpanded.value;
                    },
                    child: Icon(
                      isExpanded.value ? Icons.expand_less : Icons.expand_more,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ],
            if (isExpanded.value) ...[
              Row(
                children: [
                  Text(
                    car.id,
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    car.model,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      isExpanded.value = !isExpanded.value;
                    },
                    child: Icon(
                      isExpanded.value ? Icons.expand_less : Icons.expand_more,
                      size: 24,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Driver info',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
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
                ],
              ),
              const SizedBox(height: 8),
              if (car.driver != null) ...[
                Row(
                  children: [
                    const Icon(Icons.person),
                    const SizedBox(width: 4),
                    Text(car.driver!.name, style: const TextStyle(fontSize: 15)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.phone),
                    const SizedBox(width: 4),
                    Text(car.driver!.phone, style: const TextStyle(fontSize: 15)),
                  ],
                ),
              ],
              const SizedBox(height: 8),
              SizedBox(
                height: 100,
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(38.897957, -77.036560),
                    zoom: 13.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: const ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: LatLng(38.897957, -77.036560),
                          builder: (ctx) => const Icon(Icons.location_pin, color: Colors.red, size: 40),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 50,
                width: double.infinity,
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
                  child: const Text('Open car details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}