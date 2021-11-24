import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ulp_inmo/src/models/inmueble_model.dart';
import 'package:ulp_inmo/src/services/inmueble_services.dart';
import 'package:ulp_inmo/src/widgets/main_scaffold.dart';

class InmueblesListPage extends StatelessWidget {
  const InmueblesListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inmuebleService = Provider.of<InmuebleService>(context);

    return MainScaffold(
      navIndex: 2,
      title: const Text(
        "Mis Propiedades",
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white),
      ),
      child: FutureBuilder<List<InmuebleModel>?>(
        future: inmuebleService.getAll(),
        builder: (context, AsyncSnapshot<List<InmuebleModel>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());

            // TODO: error
          }
          if (snapshot.hasData && snapshot.data != null) {
            return snapshot.data!.isEmpty
                ? Center(
                    child: Text(
                      "No tienes propiedades",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.black),
                    ),
                  )
                : Center(
                    child: Text(
                      "Hay propiedades",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.black),
                    ),
                  );
            //TODO: Mostrar lista de inmuebles
            //TODO:NO HAY INMUEBLES
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, size: 50, color: Theme.of(context).errorColor.withOpacity(.8)),
              Center(
                child: Text('Ocrrio un error inesperado!',
                    textAlign: TextAlign.center, style: TextStyle(fontSize: 18, color: Theme.of(context).errorColor.withOpacity(.8))),
              ),
            ],
          );
        },
      ),
    );
  }
}
