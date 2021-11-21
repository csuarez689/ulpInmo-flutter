import 'package:flutter/material.dart';
import 'package:ulp_inmo/src/helpers/validators.dart';

class UserChangePassword extends StatefulWidget {
  final VoidCallback onCommit;
  const UserChangePassword({Key? key, required this.onCommit}) : super(key: key);

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
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text("Nueva contraseña", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: passwordController,
                    validator: (value) => validateBetween(value),
                    obscureText: obscurePassword,
                    decoration: InputDecoration(
                      hintText: 'Ingresa tu nueva contraseña',
                      border: InputBorder.none,
                      fillColor: const Color(0xfff3f3f4),
                      filled: true,
                      suffixIcon: IconButton(
                        splashRadius: 1.0,
                        icon: Icon(
                          obscurePassword ? Icons.visibility : Icons.visibility_off,
                          color: Colors.pink,
                        ),
                        onPressed: () => setState(() => obscurePassword = !obscurePassword),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text("Confirma tu nueva contraseña", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 10),
                  TextFormField(
                    validator: (value) => validateSame(value, passwordController.text) ? null : "Las contraseñas no coinciden",
                    onSaved: (val) => passwordConfimation = val!,
                    obscureText: obscurePasswordConfimation,
                    decoration: InputDecoration(
                      hintText: 'Confirma tu nueva contraseña',
                      border: InputBorder.none,
                      fillColor: const Color(0xfff3f3f4),
                      filled: true,
                      suffixIcon: IconButton(
                        splashRadius: 1.0,
                        icon: Icon(
                          obscurePasswordConfimation ? Icons.visibility : Icons.visibility_off,
                          color: Colors.pink,
                        ),
                        onPressed: () => setState(() => obscurePasswordConfimation = !obscurePasswordConfimation),
                      ),
                    ),
                  )
                ],
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
