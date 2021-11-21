import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ulp_inmo/src/helpers/validators.dart';
import 'package:ulp_inmo/src/services/auth_service.dart';
import 'package:ulp_inmo/src/widgets/custom_text_form_field.dart';

class UserChangePassword extends StatefulWidget {
  final VoidCallback onCommit;
  final String title;
  final Color color;

  const UserChangePassword({Key? key, required this.onCommit, required this.title, required this.color}) : super(key: key);

  @override
  State<UserChangePassword> createState() => _UserChangePasswordState();
}

class _UserChangePasswordState extends State<UserChangePassword> {
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool obscurePassword = true;
  bool obscurePasswordConfimation = true;
  String passwordConfimation = '';
  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
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
                  IconButton(onPressed: widget.onCommit, icon: Icon(Icons.chevron_left, color: widget.color, size: 35)),
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
              title: "Nueva contraseña",
              inputController: passwordController,
              validator: validateBetween,
              obscure: obscurePassword,
              hintText: 'Ingresa tu nueva contraseña',
              suffixIcon: IconButton(
                splashRadius: 1.0,
                icon: Icon(obscurePassword ? Icons.visibility : Icons.visibility_off, color: widget.color),
                onPressed: () => setState(() => obscurePassword = !obscurePassword),
              ),
            ),
            CustomTextFormField(
              title: "Confirma tu nueva contraseña",
              validator: (value) => validateSame(value, passwordController.text) ? null : "Las contraseñas no coinciden",
              obscure: obscurePasswordConfimation,
              hintText: 'Confirma tu nueva contraseña',
              onSaved: (val) => passwordConfimation = val!,
              suffixIcon: IconButton(
                splashRadius: 1.0,
                icon: Icon(
                  obscurePasswordConfimation ? Icons.visibility : Icons.visibility_off,
                  color: Colors.pink,
                ),
                onPressed: () => setState(() => obscurePasswordConfimation = !obscurePasswordConfimation),
              ),
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
                  widget.onCommit();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
