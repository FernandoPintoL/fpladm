import 'package:flutter/material.dart';
import '../config/pallet.dart';
import '../dashboard/tapMenuDetalles.dart';
import '../dashboard/tap_info_list.dart';

class HomeMobile extends StatelessWidget {
  const HomeMobile({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Inicio"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: bgColor
              ),
                currentAccountPicture: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  height: 70,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/profile.png'),
                    ),
                  ),
                ),
                accountName: const Text("Fernando Pinto Lino"),
                accountEmail: const Text("pintolinofernando@gmail.com")
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: const Text('Inicio'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TapMenuDetalles(listTaps: demoMyTaps),
      ),
    );
  }
}
