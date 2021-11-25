import 'package:flutter/material.dart';
import 'package:ulp_inmo/src/models/inmueble_model.dart';
import 'package:ulp_inmo/src/widgets/main_scaffold.dart';

class InmueblesDetailPage extends StatelessWidget {
  const InmueblesDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inmueble = ModalRoute.of(context)!.settings.arguments as InmuebleModel;
    return MainScaffold(
      title: const Text(
        "Mi Propiedad",
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white),
      ),
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[],
      )),
    );
  }
}
