import 'package:flutter/material.dart';
import 'package:ulp_inmo/src/widgets/main_scaffold.dart';

class InmueblesDetailPage extends StatelessWidget {
  const InmueblesDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(navIndex: 2, child: Center(child: Text('Detail Inmuebles')));
  }
}
