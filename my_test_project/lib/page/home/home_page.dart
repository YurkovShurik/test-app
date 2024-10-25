import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:my_test_project/tab/status_tab.dart';

class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(2);
    final navigatorKey = GlobalKey<NavigatorState>();

    final List<Widget> pages = [
      const Center(child: Text("Company page")),
      const Center(child: Text("Cars page")),
      StatusTab(navigatorKey: navigatorKey),
      const Center(child: Text("Help page")),
    ];

    void onItemTapped(int index) {
      selectedIndex.value = index;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Row(
          children: [
            Image.asset(
              'assets/image/logo.png',
              height: 40,
            ),
            const SizedBox(width: 10),
            const Text(
              'Security Rent',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black, size: 30),
            onPressed: () {},
          ),
        ],
      ),
      body: Navigator(
        key: navigatorKey,
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => pages[selectedIndex.value],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex.value,
        onTap: onItemTapped,
        selectedItemColor: Colors.indigoAccent,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: ColorFiltered(
              colorFilter: ColorFilter.mode(
                selectedIndex.value == 0 ? Colors.indigoAccent : Colors.grey,
                BlendMode.srcIn,
              ),
              child: Image.asset('assets/image/company.png', height: 40),
            ),
            label: 'Company',
          ),
          BottomNavigationBarItem(
            icon: ColorFiltered(
              colorFilter: ColorFilter.mode(
                selectedIndex.value == 1 ? Colors.indigoAccent : Colors.grey,
                BlendMode.srcIn,
              ),
              child: Image.asset('assets/image/car.png', height: 40),
            ),
            label: 'Cars',
          ),
          BottomNavigationBarItem(
            icon: ColorFiltered(
              colorFilter: ColorFilter.mode(
                selectedIndex.value == 2 ? Colors.indigoAccent : Colors.grey,
                BlendMode.srcIn,
              ),
              child: Image.asset('assets/image/status.png', height: 40),
            ),
            label: 'Status',
          ),
          BottomNavigationBarItem(
            icon: ColorFiltered(
              colorFilter: ColorFilter.mode(
                selectedIndex.value == 3 ? Colors.indigoAccent : Colors.grey,
                BlendMode.srcIn,
              ),
              child: Image.asset('assets/image/help.png', height: 40),
            ),
            label: 'Help',
          ),
        ],
      ),
    );
  }
}