import 'package:flutter/material.dart';
import 'package:web_app/routes.dart';

void main() {
  runApp(MyApp());
}

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
