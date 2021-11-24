import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ulp_inmo/src/helpers/validators.dart';
import 'package:ulp_inmo/src/models/user_model.dart';
import 'package:ulp_inmo/src/services/auth_service.dart';
import 'package:ulp_inmo/src/widgets/custom_text_form_field.dart';
import 'package:ulp_inmo/src/widgets/loader_button.dart';
import 'package:ulp_inmo/src/helpers/snackbar_notifications.dart';

class UserEditInfo extends StatefulWidget {
  final Color color;
  final String title;

  const UserEditInfo({Key? key, required this.color, required this.title}) : super(key: key);

  @override
  State<UserEditInfo> createState() => _UserEditInfoState();
}

class _UserEditInfoState extends State<UserEditInfo> {
  final formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    UserModel user = UserModel.fromJson(authService.authUser!.toJson());

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
                  IconButton(onPressed: () => Navigator.maybePop(context), icon: Icon(Icons.chevron_left, color: widget.color, size: 35)),
                  Text(widget.title,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xff14279B),
                          decoration: TextDecoration.underline,
                          decorationThickness: 4,
                          decorationColor: widget.color.withOpacity(.2))),
                ],
              ),
            ),
            CustomTextFormField(
              title: "Nombre",
              validator: (value) => validateBetween(value, 5, 30),
              hintText: 'Ingresa tu nombre',
              onSaved: (val) => user.nombre = val!,
              initialValue: user.nombre,
            ),
            CustomTextFormField(
              title: "Teléfono",
              validator: (value) => validateBetween(value, 9, 15),
              hintText: 'Ingresa tu telefono',
              keyboardType: TextInputType.phone,
              onSaved: (val) => user.telefono = val!,
              initialValue: user.telefono,
            ),
            CustomTextFormField(
              title: "Correo Electrónico",
              validator: validateEmail,
              hintText: 'Ingresa tu correo electrónico',
              keyboardType: TextInputType.emailAddress,
              onSaved: (val) => user.email = val!,
              initialValue: user.email,
            ),
            const SizedBox(height: 20),
            LoaderButton(
              loading: loading,
              child: const Text('Guardar'),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  setState(() => loading = true);
                  final res = await authService.updateProfile(user, null);
                  if (res != null)
                    // ignore: curly_braces_in_flow_control_structures
                    showSnackbarError(context, res);
                  else {
                    Navigator.maybePop(context);
                    showSnackbar(context, 'Perfil actualizado');
                  }
                  setState(() => loading = false);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
