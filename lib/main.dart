import 'package:flutter/material.dart';
import 'package:web_app/routes.dart';

void main() {
  runApp(MyApp());
}

/// Main widget that initializes the MaterialApp and its parameters.
/// Through the routes function it determins the Home widget as the main route.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Analyst-Frontend',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: routes(),
    );
  }
}
