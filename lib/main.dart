import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'providers/item_provider.dart';
import 'providers/menu_app_provider.dart';
import 'providers/user_provider.dart';
import 'view/config/pallet.dart';
import 'view/home/home_page.dart';
import 'view/item/item_view.dart';
import 'view/user/user_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MenuAppProvider>(
            create: (_) => MenuAppProvider()),
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
        ChangeNotifierProvider<ItemProvider>(create: (_) => ItemProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Soluciones LP',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.white),
          canvasColor: secondaryColor,
        ),
        routes: {
          '/': (_) => const HomePage(),
          '/homePage': (_) => const HomePage(),
          '/userview': (_) => const UserView(),
          '/itemview': (_) => const ItemView(),
          // '/roleview' : (_) => const RoleView(),
        },
        initialRoute: '/',
        //home: const HomePage()
      ),
    );
  }
}
