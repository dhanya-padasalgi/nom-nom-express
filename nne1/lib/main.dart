import 'package:flutter/material.dart';
import 'package:nom_nom_express/home.dart';
import 'package:nom_nom_express/signlog.dart';
void main() {
  runApp(
    MaterialApp(
      title: 'Welcome App',
      home: WelcomePage(),
      routes: {
        '/home': (context) => MyHomePage(),
        '/signlog': (context) => LoginSignupPage(),
        // '/page3': (context) => Page3(),
        // '/page4': (context) => Page4(),
      },
      theme: ThemeData(
        platform: TargetPlatform.android,
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
    ),
  );
}


class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              child: Text('home'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signlog');
              },
              child: Text('sign log'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/page3');
              },
              child: Text('Page 3'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/page4');
              },
              child: Text('Page 4'),
            ),
          ],
        ),
      ),
    );
  }
}