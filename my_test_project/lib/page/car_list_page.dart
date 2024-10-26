import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:my_test_project/component/FutureListView.dart';
import 'package:my_test_project/component/card/car_card_for_cars.dart';
import 'package:my_test_project/entity/car.dart';
import 'package:my_test_project/fetch/fetch_cars.dart';
import 'package:my_test_project/hook/ListenableFuture.dart';

class CarListPage extends HookWidget {

  final GlobalKey<NavigatorState> navigatorKey;
  final bool? useOnTab;

  const CarListPage({
    Key? key,
    required this.navigatorKey,
    this.useOnTab = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final carListSnapshot = useListenableFuture(fetchCars);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                useOnTab! ?
                const SizedBox() :
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 18),
                  ),
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'All cars',
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
                itemBuilder: (context, car, index) => CarCardForCars(
                  car: car,
                  navigatorKey: navigatorKey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}