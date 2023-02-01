import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pomodoro/ui/page/home_screen.dart';
import 'package:pomodoro/ui/page/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

/// The route configuration.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'onboarding',
          builder: (BuildContext context, GoRouterState state) {
            return const OnBoardingScreen();
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
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
      routerConfig: _router,
    );
  }
}
