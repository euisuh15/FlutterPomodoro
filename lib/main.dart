import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pomodoro/ui/page/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Design from referenced from https://www.behance.net/gallery/98918603/POMO-UIKIT
    return MaterialApp(
      title: 'Pomodoro',
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
        primaryColor: const Color(0xFFE7626C),
        dividerColor: const Color(0xFFF4EDDB),
        backgroundColor: const Color(0xFFFFFFFE),
        disabledColor: const Color(0xFF232B55),
        cardColor: const Color(0xFFF4EDDB),
      ),
      home: const HomeScreen(),
    );
  }
}
