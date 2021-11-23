import 'package:flutter/material.dart';
import 'package:ulp_inmo/src/widgets/main_scaffold.dart';

class InmueblesListPage extends StatelessWidget {
  const InmueblesListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(navIndex: 2, child: Center(child: Text('Lista Inmuebles')));
  }
}
