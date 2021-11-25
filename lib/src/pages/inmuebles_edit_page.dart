import 'package:flutter/material.dart';
import 'package:ulp_inmo/src/widgets/main_scaffold.dart';

class InmueblesEditPage extends StatelessWidget {
  const InmueblesEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(navIndex: 2, body: Center(child: Text('Edit Inmuebles')));
  }
}
