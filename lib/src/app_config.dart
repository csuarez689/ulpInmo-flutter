import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ulp_inmo/src/pages/inmuebles_add_page.dart';
import 'package:ulp_inmo/src/pages/inmuebles_detail_page.dart';
import 'package:ulp_inmo/src/pages/inmuebles_edit_page.dart';
import 'package:ulp_inmo/src/pages/inmuebles_list_page.dart';
import 'package:ulp_inmo/src/pages/login_page.dart';
import 'package:ulp_inmo/src/pages/profile_page.dart';
import 'package:ulp_inmo/src/services/auth_service.dart';
import 'package:ulp_inmo/src/services/http_service.dart';
import 'package:ulp_inmo/src/services/inmueble_services.dart';

_configStatusBar() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.black,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.dark,
    systemStatusBarContrastEnforced: true,
  )); //)  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

initApp(Widget app) async {
  WidgetsFlutterBinding.ensureInitialized();
  _configStatusBar();
  final _httpService = HttpService('http://practicastuds.ulp.edu.ar/api', {'Content-Type': "application/json; charser=UTF-8"});

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthService>(create: (context) => AuthService(_httpService)),
      Provider<InmuebleService>(create: (context) => InmuebleService(_httpService)),
    ],
    child: app,
  ));
}

ThemeData getAppTheme() => ThemeData.light().copyWith(
    primaryColor: const Color(0xff14279B),
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light().copyWith(
      primaryVariant: const Color(0xff4b628b),
      primary: const Color(0xff14279B),
      secondary: Colors.pink.withOpacity(.9),
      secondaryVariant: const Color(0xffac4180),
    ));

Map<String, Widget Function(BuildContext)> getRoutes() => {
      '/login': (_) => LoginPage(),
      '/profile': (context) => ProfilePage(context),
      '/inmuebles': (context) => InmueblesListPage(),
      '/inmuebles/edit': (context) => InmueblesEditPage(),
      '/inmuebles/detail': (context) => InmueblesDetailPage(),
      '/inmuebles/add': (context) => InmueblesAddPage(),
    };
