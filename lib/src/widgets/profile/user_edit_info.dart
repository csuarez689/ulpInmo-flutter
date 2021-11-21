import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ulp_inmo/src/helpers/validators.dart';
import 'package:ulp_inmo/src/services/auth_service.dart';
import 'package:ulp_inmo/src/widgets/custom_text_form_field.dart';

class UserEditInfo extends StatelessWidget {
  final VoidCallback onCommit;
  final formKey = GlobalKey<FormState>();
  final Color color;
  final String title;

  UserEditInfo({Key? key, required this.onCommit, required this.color, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthService>(context, listen: false).authUser;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(onPressed: onCommit, icon: Icon(Icons.chevron_left, color: color, size: 35)),
                  Text(title,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xff14279B),
                          decoration: TextDecoration.underline,
                          decorationThickness: 4,
                          decorationColor: color.withOpacity(.2))),
                ],
              ),
            ),
            CustomTextFormField(
              title: "Nombre",
              validator: (value) => validateBetween(value, 5, 30),
              hintText: 'Ingresa tu nombre',
              onSaved: (val) => user?.nombre = val!,
              initialValue: user?.nombre,
            ),
            CustomTextFormField(
              title: "Teléfono",
              validator: (value) => validateBetween(value, 9, 15),
              hintText: 'Ingresa tu telefono',
              keyboardType: TextInputType.phone,
              onSaved: (val) => user?.phone = val!,
              initialValue: user?.phone,
            ),
            CustomTextFormField(
              title: "Correo Electrónico",
              validator: validateEmail,
              hintText: 'Ingresa tu correo electrónico',
              keyboardType: TextInputType.emailAddress,
              onSaved: (val) => user?.email = val!,
              initialValue: user?.email,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: const Color(0xff14279B),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  textStyle: const TextStyle(fontSize: 20, color: Colors.white),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  minimumSize: const Size.fromHeight(50)),
              child: const Text('Guardar'),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  onCommit();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
