import 'package:flutter/material.dart';
import '../view/dashboard/tap_info_list.dart';
import '../view/dashboard/tablero.dart';

class MenuAppProvider extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  dynamic currentPage = DrawerSections.homePage;
  Widget container = const Center(child: Text('Iniciando...'));

  MenuAppProvider(){
    container = Tablero(title: 'INICIO', listTaps: demoMyTaps);
    notifyListeners();
  }

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  Widget get getContainer => container;

  dynamic get getCurrentPage => currentPage;

  void changePage(int id){
    // if (id == 1) {
    //   currentPage = DrawerSections.homePage;
    //   container = Tablero(title: 'Home', listTaps: demoMyTaps);
    //   notifyListeners();
    // } else if (id == 2) {
    //   currentPage = DrawerSections.gestionUsuario;
    //   container = const GestionUsuario();
    //   notifyListeners();
    // }
  }

  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }
}

enum DrawerSections {
  homePage,
  gestionUsuario,
}