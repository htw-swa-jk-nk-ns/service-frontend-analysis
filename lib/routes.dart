import 'package:flutter/material.dart';
import 'package:web_app/screens/analyse.dart';
import 'package:web_app/screens/home.dart';

const homeRoute = "/";
const analyseRoute = "/analyse";

RouteFactory routes() {
  return (settings) {
    final Map<String, dynamic> arguments = settings.arguments;
    Widget screen;

    switch (settings.name) {
      case homeRoute:
        screen = Home();
        break;
      case analyseRoute:
        screen = Analyse();
        break;
      default:
        return null;
    }

    return MaterialPageRoute(builder: (BuildContext context) => screen);
  };
}
