import 'package:flutter/material.dart';
import 'package:ulp_inmo/src/app_config.dart';

void main() {
  initApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getAppTheme(),
      title: 'ULP Inmobiliaria',
      initialRoute: getInitialRoute(),
      routes: getRoutes(),
    );
  }
}
