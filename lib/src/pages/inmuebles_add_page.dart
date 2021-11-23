import 'package:flutter/material.dart';
import 'package:ulp_inmo/src/widgets/main_scaffold.dart';

class InmueblesAddPage extends StatelessWidget {
  const InmueblesAddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(navIndex: 2, child: Center(child: Text('Add Inmuebles')));
  }
}
