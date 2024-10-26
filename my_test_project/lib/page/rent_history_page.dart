import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:my_test_project/entity/car.dart';

class RentHistoryPage extends HookWidget {

  final Car car;
  final GlobalKey<NavigatorState> navigatorKey;

  const RentHistoryPage({
    Key? key,
    required this.car,
    required this.navigatorKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

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
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Rent history",
                    style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}