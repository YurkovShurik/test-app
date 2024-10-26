import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:my_test_project/component/FutureListView.dart';
import 'package:my_test_project/component/car_card_for_status.dart';
import 'package:my_test_project/entity/car.dart';
import 'package:my_test_project/fetch/fetch_cars.dart';
import 'package:my_test_project/hook/ListenableFuture.dart';
import 'package:my_test_project/page/car_details_page.dart';

class StatusTab extends HookWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const StatusTab({
    Key? key,
    required this.navigatorKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final carListSnapshot = useListenableFuture(fetchCars);

    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Car status',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: const Icon(
                      Icons.filter_list,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Flexible(
            child: FutureListView<Car>(
              snapshot: carListSnapshot,
              itemBuilder: (context, car, index) => CarCardForStatus(
                car: car,
                navigatorKey: navigatorKey,
                onPressed: () {
                  navigatorKey.currentState!.push(
                    MaterialPageRoute(
                      builder: (context) => CarDetailsPage(car: car, navigatorKey: navigatorKey),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}