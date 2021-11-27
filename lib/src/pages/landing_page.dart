import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ulp_inmo/src/pages/inmuebles_list_page.dart';
import 'package:ulp_inmo/src/pages/login_page.dart';

import 'package:ulp_inmo/src/services/auth_service.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(builder: (_, authService, __) {
      return authService.authUser == null ? const LoginPage() : const InmueblesListPage();
    });
  }
}
