import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:ulp_inmo/src/helpers/notifications.dart';
import 'package:ulp_inmo/src/helpers/validators.dart';

import 'package:ulp_inmo/src/models/inmueble_model.dart';
import 'package:ulp_inmo/src/services/inmueble_services.dart';

import 'package:ulp_inmo/src/widgets/custom_text_form_field.dart';
import 'package:ulp_inmo/src/widgets/loader_button.dart';
import 'package:ulp_inmo/src/pages/main_scaffold.dart';
import 'package:ulp_inmo/src/widgets/single_marker_map.dart';

class InmueblesFormPage extends StatefulWidget {
  final BuildContext parentContext;
  const InmueblesFormPage(this.parentContext, {Key? key}) : super(key: key);

  @override
  State<InmueblesFormPage> createState() => _InmueblesFormPageState();
}

class _InmueblesFormPageState extends State<InmueblesFormPage> {
  final formKey = GlobalKey<FormState>();
  late InmuebleModel inmueble;
  late bool isEditing;
  bool loading = false;
  bool? validLocation;

  @override
  void initState() {
    super.initState();
    final route = ModalRoute.of(widget.parentContext);
    if (route != null && route.settings.arguments != null) {
      inmueble = route.settings.arguments as InmuebleModel;
      isEditing = true;
    } else {
      inmueble = InmuebleModel(direccion: '', superficie: 0);
      isEditing = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final inmuebleService = Provider.of<InmuebleService>(context);

    return MainScaffold(
      title: Text(
        isEditing ? "Editar Propiedad" : "Nueva Propiedad",
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white),
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text("Seleccione la ubicación", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    height: 450,
                    width: MediaQuery.of(context).size.width,
                    child: SingleMarkerMap(
                      lat: inmueble.latitud,
                      lng: inmueble.longitud,
                      onMapTap: (lat, lng) => setState(() {
                        inmueble.latitud = lat;
                        inmueble.longitud = lng;
                      }),
                    ),
                  ),
                  if (validLocation != null && !validLocation!)
                    Text('Debe seleccionar la ubicación de la propiedad', style: TextStyle(color: Theme.of(context).errorColor, fontSize: 12)),
                  CustomTextFormField(
                    textInputAction: TextInputAction.next,
                    title: "Dirección",
                    validator: (value) => validateBetween(value, min: 6, max: 120),
                    hintText: 'Ingresa la dirección de la propiedad',
                    onSaved: (val) => inmueble.direccion = val!,
                    initialValue: inmueble.direccion,
                  ),
                  CustomTextFormField(
                    textInputAction: TextInputAction.done,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*'))],
                    title: "Superficie (m2)",
                    validator: (value) => validateNumberBetween(int.tryParse(value) ?? 0, min: 5, max: 100000),
                    hintText: 'Ingresa la superficie de la propiedad (m2)',
                    keyboardType: const TextInputType.numberWithOptions(),
                    onSaved: (val) => inmueble.superficie = int.tryParse(val!) ?? 0,
                    initialValue: inmueble.superficie.toString(),
                  ),
                  const SizedBox(height: 20),
                  LoaderButton(
                    loading: loading,
                    child: const Text('Guardar'),
                    onPressed: () async {
                      if (inmueble.latitud == null || inmueble.longitud == null) {
                        setState(() => validLocation = false);
                        return;
                      }
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        setState(() => loading = true);
                        final res = isEditing ? await inmuebleService.update(inmueble) : await inmuebleService.create(inmueble);
                        if (res == null) {
                          showSnackbarError(context, 'No se ha podido realizar la operación');
                        } else {
                          Navigator.maybePop(context, true);
                          showSnackbar(context, res);
                        }
                        setState(() => loading = false);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
