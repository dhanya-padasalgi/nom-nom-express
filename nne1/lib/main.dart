import 'package:flutter/material.dart';
import 'package:nom_nom_express/home.dart';
import 'package:nom_nom_express/signlog.dart';

double fem = 1;
double ffem = 1;

void main() {
  runApp(MaterialApp(
    home: MyHomePage(title: 'home'),
    
  ));
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'nne',
      theme: ThemeData(
        platform: TargetPlatform.android, // Target Android platform
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),


        canvasColor: Color(0xFF021141), 
        colorScheme: ColorScheme.dark(
        secondary: Color(0xFF8080D7),
        primary: Color(0xFFD9D9D9),
      ).copyWith(
        onPrimary: Color(0xFF000000), 
        onSecondary: Color(0xFFFFFFFF), 
        surface: Color(0xFF010719), 
        onSurface: Color(0xFFFFFFFF),
      ),

        dialogBackgroundColor: Color(0xFF8080D7), 
      ),
      initialRoute: '/',
      routes: {
        '/home': (context) => MyHomePage(title: 'home',),
        '/signlog': (context) => LoginSignupPage(),
        // '/profile': (context) => ProfilePage(),
        // '/billing': (context) => BillingPage(),
        // '/menu': (context) => MenuPage(),
        // '/login': (context) => LoginPage(),
        // '/welcome': (context) => WelcomePage(),
      },
    );
  }
}

