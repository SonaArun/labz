import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'repositories/index.dart';
import 'screens/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ProductRepository()),
      ],
      child: ChangeNotifierProvider(
      create: (context) => ProductRepository(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: const ColorScheme(
              primary: Color.fromARGB(255, 244,249,250),
              secondary: Color.fromARGB(255, 244,249,250),
              surface: Color.fromARGB(255, 244,249,250),
              background: Color.fromARGB(255, 244,249,250),
              error: Color.fromARGB(255, 244,249,250),
              onPrimary: Color.fromARGB(255, 244,249,250),
              onSecondary: Color.fromARGB(255, 244,249,250),
              onSurface: Color.fromARGB(255, 244,249,250),
              onBackground: Color.fromARGB(255, 244,249,250),
              onError: Color.fromARGB(255, 244,249,250),
              brightness: Brightness.light,
            ),
          ),
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/':
              case '/login':
                return MaterialPageRoute(builder: (_) => const LoginScreen());
              case '/home':
                return PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const HomeScreen(),
                  transitionsBuilder: (_, animation, __, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                );
              default:
                return null;
            }
          },
          initialRoute: '/login',
          home: const LoginScreen(),
        ),
      ),
    );
  }
}