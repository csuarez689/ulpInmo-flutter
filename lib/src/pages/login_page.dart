import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ulp_inmo/src/services/auth_service.dart';

import 'package:ulp_inmo/src/helpers/validators.dart';
import 'package:ulp_inmo/src/helpers/notifications.dart';

import 'package:ulp_inmo/src/widgets/custom_text_form_field.dart';
import 'package:ulp_inmo/src/widgets/loader_button.dart';
import 'package:ulp_inmo/src/widgets/stain_bg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  bool obscurePassword = true;
  String email = '';
  String password = '';
  late final authService = Provider.of<AuthService>(context, listen: false);
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SizedBox(
        height: height,
        child: Stack(
          children: <Widget>[
            const StainBg(),
            Center(
              child: Container(
                margin: const EdgeInsets.only(bottom: 20, left: 40, right: 40),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: const Color(0xff14279B)),
                        child: const Icon(Icons.house_rounded, color: Colors.white, size: 80),
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'ULP',
                          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: Color(0xff14279B)),
                          children: [
                            TextSpan(
                              text: 'Inmo',
                              style: TextStyle(color: Colors.pink.withOpacity(.8), fontSize: 30),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                      Form(
                        key: formKey,
                        child: Column(
                          children: <Widget>[
                            CustomTextFormField(
                              initialValue: 'csuarez689@gmail.com',
                              keyboardType: TextInputType.emailAddress,
                              title: "Correo Electrónico",
                              validator: validateEmail,
                              hintText: 'Ingresa tu correo electrónico',
                              onSaved: (val) => email = val!,
                            ),
                            CustomTextFormField(
                              initialValue: '12345',
                              title: "Contraseña",
                              validator: validateBetween,
                              obscure: obscurePassword,
                              hintText: 'Ingresa tu contraseña',
                              onSaved: (val) => password = val!,
                              suffixIcon: IconButton(
                                splashRadius: 1.0,
                                icon: Icon(
                                  obscurePassword ? Icons.visibility : Icons.visibility_off,
                                  color: Colors.pink,
                                ),
                                onPressed: () => setState(() => obscurePassword = !obscurePassword),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      LoaderButton(
                        loading: loading,
                        child: const Text('Ingresar'),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            setState(() => loading = true);
                            final res = await authService.login(email, password);
                            if (res != null)
                              showSnackbarError(context, res);
                            else
                              Navigator.pushReplacementNamed(context, '/inmuebles');
                            setState(() => loading = false);
                          }
                        },
                      ),
                      const SizedBox(height: 5),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.pink,
                            textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, decoration: TextDecoration.underline),
                          ),
                          child: const Text('¿ Olvidaste tu contraseña ?'),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
