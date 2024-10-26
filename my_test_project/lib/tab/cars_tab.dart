import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:my_test_project/page/car_list_page.dart';

class CarsTab extends HookWidget {

  final GlobalKey<NavigatorState> navigatorKey;

  const CarsTab({
    Key? key,
    required this.navigatorKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return CarListPage(navigatorKey: navigatorKey);
  }
}