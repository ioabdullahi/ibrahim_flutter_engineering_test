import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibrahim_abdullahi_flutter_engineering_translation_test/models/property.dart';
import 'package:ibrahim_abdullahi_flutter_engineering_translation_test/views/home_view.dart';
import 'package:ibrahim_abdullahi_flutter_engineering_translation_test/views/main_view.dart';
import 'package:ibrahim_abdullahi_flutter_engineering_translation_test/views/map_view.dart';
import 'package:ibrahim_abdullahi_flutter_engineering_translation_test/views/property_detail_view.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        if (settings.name == '/propertyDetail') {
          final property = settings.arguments as Property;
          return _customPageRoute(PropertyDetailView(property: property));
        }
        switch (settings.name) {
          case '/map':
            return _customPageRoute(const MapView());
          default:
            return _customPageRoute(const HomeView());
        }
      },
      home: MainScreen(),
    );
  }
}

PageRouteBuilder _customPageRoute(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 600),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: animation.drive(Tween(begin: 0.95, end: 1.0)),
          child: child,
        ),
      );
    },
  );
}
