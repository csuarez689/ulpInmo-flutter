import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:ulp_inmo/src/helpers/notifications.dart';
import 'package:ulp_inmo/src/helpers/validators.dart';

import 'package:ulp_inmo/src/models/inmueble_model.dart';
import 'package:ulp_inmo/src/services/inmueble_services.dart';

import 'package:ulp_inmo/src/widgets/custom_text_form_field.dart';
import 'package:ulp_inmo/src/widgets/loader_button.dart';
import 'package:ulp_inmo/src/widgets/main_scaffold.dart';

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

  @override
  void initState() {
    super.initState();
    final route = ModalRoute.of(widget.parentContext);
    if (route != null && route.settings.arguments != null) {
      inmueble = route.settings.arguments as InmuebleModel;
      isEditing = true;
    } else {
      inmueble = InmuebleModel(direccion: '', superficie: 0, latitud: 0.0, longitud: 0.0);
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
          child: Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            alignment: Alignment.center,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomTextFormField(
                    title: "Dirección",
                    validator: (value) => validateBetween(value, min: 6, max: 120),
                    hintText: 'Ingresa la dirección de la propiedad',
                    onSaved: (val) => inmueble.direccion = val!,
                    initialValue: inmueble.direccion,
                  ),
                  CustomTextFormField(
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*'))],
                    title: "Superficie (m2)",
                    validator: (value) => validateNumberBetween(int.tryParse(value) ?? 0, min: 5, max: 100000),
                    hintText: 'Ingresa la superficie de la propiedad (m2)',
                    keyboardType: const TextInputType.numberWithOptions(),
                    onSaved: (val) => inmueble.superficie = int.tryParse(val!) ?? 0,
                    initialValue: inmueble.superficie.toString(),
                  ),
                  CustomTextFormField(
                    title: "Latitud",
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d{0,10}'))],
                    hintText: 'Ingresa la latitud de la propiedad',
                    keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                    onSaved: (val) => inmueble.latitud = double.tryParse(val!) ?? 0.0,
                    initialValue: inmueble.latitud.toString(),
                  ),
                  CustomTextFormField(
                    title: "Longitud",
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d{0,10}'))],
                    hintText: 'Ingresa la logitud de la propiedad',
                    keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                    onSaved: (val) => inmueble.longitud = double.tryParse(val!) ?? 0.0,
                    initialValue: inmueble.longitud.toString(),
                  ),
                  const SizedBox(height: 20),
                  LoaderButton(
                    loading: loading,
                    child: const Text('Guardar'),
                    onPressed: () async {
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
