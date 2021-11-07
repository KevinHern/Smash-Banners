import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Screens
import 'smash_banner.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Smash Banners',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,

        // Color theme data
        primaryColor: const Color(0xFF3a93e0),
        primaryColorLight: const Color(0xFF77c3ff),
        primaryColorDark: const Color(0xFF0066ae),
        accentColor: const Color(0xFFbd1502),
        backgroundColor: const Color(0xFFf7f5cd),
        scaffoldBackgroundColor: const Color(0xFFf7f3d0),
        iconTheme: IconThemeData(
          color: Colors.white70,
        ),

        // Font Data Theme
        // Font Data
        textTheme: TextTheme(
          headline1: GoogleFonts.asap(
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
          headline2: GoogleFonts.asap(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          headline3: GoogleFonts.asap(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          subtitle1: GoogleFonts.exo(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          bodyText1: GoogleFonts.merriweather(
              fontSize: 18, color: Colors.black, letterSpacing: 1.0),
        ),

        // Button Style Theme Data
        buttonTheme: ButtonThemeData(
          buttonColor: Theme.of(context).accentColor,
          disabledColor: Colors.grey,
          hoverColor: const Color(0xFFf75230),
          splashColor: const Color(0xFFf75230),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shadowColor: Colors.black12,
            primary: Theme.of(context).accentColor,
            textStyle: TextStyle(
              fontFamily: Theme.of(context).textTheme.bodyText1!.fontFamily,
            ),
          ),
        ),

        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 6.0,
        ),

        inputDecorationTheme: InputDecorationTheme(
          errorStyle: GoogleFonts.lato(
              textStyle: TextStyle(
            color: Color(0xFFde0b0b),
          )),
          labelStyle: GoogleFonts.lato(
              textStyle: TextStyle(
            color: Theme.of(context).primaryColor,
          )),
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 0.0),
            borderRadius: BorderRadius.circular(16),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).primaryColorDark, width: 2.0),
            borderRadius: BorderRadius.circular(12),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFde0b0b), width: 0.0),
            borderRadius: BorderRadius.circular(16),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFa30000), width: 2.0),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => SmashBannerScreen(),
      },
    );
  }
}
