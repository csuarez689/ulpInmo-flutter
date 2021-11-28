import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:ulp_inmo/src/services/auth_service.dart';
import 'package:ulp_inmo/src/services/http_service.dart';
import 'package:ulp_inmo/src/services/inmueble_services.dart';

import 'package:ulp_inmo/src/pages/inmuebles_detail_page.dart';
import 'package:ulp_inmo/src/pages/inmuebles_form_page.dart';
import 'package:ulp_inmo/src/pages/inmuebles_list_page.dart';
import 'package:ulp_inmo/src/pages/profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  final _httpService = HttpService('http://practicastuds.ulp.edu.ar/api', {'Content-Type': "application/json; charser=UTF-8"});
  final _authService = AuthService(_httpService);
  await _authService.checkAuthUser();
  runApp(MultiProvider(
    providers: [
      Provider(create: (_) => _httpService),
      ChangeNotifierProvider(create: (_) => _authService),
      Provider(create: (_) => InmuebleService(_httpService)),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: const Color(0xff14279B),
        scaffoldBackgroundColor: Colors.white,
        colorScheme: const ColorScheme.light().copyWith(
          primaryVariant: const Color(0xff4b628b),
          primary: const Color(0xff14279B),
          secondary: Colors.pink.withOpacity(.9),
          secondaryVariant: const Color(0xffac4180),
        ),
      ),
      title: 'ULPInmo',
      routes: {
        '/profile': (context) => const ProfilePage(),
        '/inmuebles': (context) => const InmueblesListPage(),
        '/inmuebles/detail': (context) => const InmueblesDetailPage(),
        '/inmuebles/form': (context) => InmueblesFormPage(context),
      },
      initialRoute: '/inmuebles',
    );
  }
}
