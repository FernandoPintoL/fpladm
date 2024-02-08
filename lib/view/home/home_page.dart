import 'package:flutter/material.dart';
import '../config/pallet.dart';
import '../dashboard/tapMenuDetalles.dart';
import '../dashboard/tap_info_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                decoration: const BoxDecoration(color: bgColor),
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
                accountEmail: const Text("pintolinofernando@gmail.com")),
            ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: const Text('Inicio'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.supervised_user_circle_outlined,
              ),
              title: const Text('Gestion Usuarios'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/userview");
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.list_alt,
              ),
              title: const Text('Inventario / Catálogo'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/itemview");
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: TapMenuDetalles(listTaps: demoMyTaps),
      ),
    );
    // return const Responsive(
    //   mobile: HomeMobile(),
    //   desktop: HomeDesktop(),
    // );
    // return Scaffold(
    //   key: context.read<MenuAppProvider>().scaffoldKey,
    //   body: SafeArea(
    //     child: Row(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         if(!Responsive.isMobile(context))
    //           const Expanded(
    //             child: MenuGeneral(),
    //           ),
    //         Expanded(
    //           flex: 5,
    //           child: Consumer<MenuAppProvider>(
    //             builder: (_, menuAppProvider, child) {
    //               return menuAppProvider.container;
    //             },
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    //   drawer: const MenuGeneral(),
    // );
  }
}
