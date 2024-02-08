import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/menu_app_provider.dart';
import '../config/pallet.dart';
import '../components/responsive.dart';

class MenuGeneral extends StatelessWidget {
  const MenuGeneral({super.key});
  @override
  Widget build(BuildContext context) {
    return const Drawer(
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            MyHeaderDrawer(),
            DrawerItemList(),
          ],
        ),
      ),
    );
  }
}

class DrawerItemList extends StatelessWidget {
  const DrawerItemList({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          ItemMenu(
              id: 1,
              title: "Inicio",
              icon: Icons.dashboard_outlined,
              selected: context.watch<MenuAppProvider>().currentPage == DrawerSections.homePage ? true : false
          ),
          ItemMenu(
              id: 2,
              title: "Gestion de Usuario",
              icon: Icons.supervised_user_circle_outlined,
              selected: context.watch<MenuAppProvider>().currentPage == DrawerSections.gestionUsuario ? true : false
          ),
          ItemMenu(
              id: 2,
              title: "Inventario / Catálogo",
              icon: Icons.supervised_user_circle_outlined,
              selected: context.watch<MenuAppProvider>().currentPage == DrawerSections.gestionUsuario ? true : false
          ),
        ],
      ),
    );
  }
}


class ItemMenu extends StatelessWidget {
  int id;
  String title;
  IconData icon;
  bool selected;
  ItemMenu({
    required this.id,
    required this.title,
    required this.icon,
    required this.selected,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          if(Responsive.isMobile(context)) Navigator.pop(context);
          Provider.of<MenuAppProvider>(context, listen: false).changePage(id);
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyHeaderDrawer extends StatefulWidget {
  const MyHeaderDrawer({super.key});

  @override
  State<MyHeaderDrawer> createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 70,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/profile.png'),
              ),
            ),
          ),
          const Text(
            "Fernando Pinto Lino",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Text(
            "pintolinofernando@gmail.com",
            style: TextStyle(
              color: Colors.grey[200],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

