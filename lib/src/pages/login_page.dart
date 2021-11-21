import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ulp_inmo/src/helpers/validators.dart';
import 'package:ulp_inmo/src/models/user_model.dart';
import 'package:ulp_inmo/src/services/auth_service.dart';
import 'package:ulp_inmo/src/widgets/custom_text_form_field.dart';
import 'package:ulp_inmo/src/widgets/stain_bg.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  bool obscurePassword = true;
  String email = '';
  String password = '';
  late final authProvider = Provider.of<AuthService>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            StainBg(),
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
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xff14279B),
                        ),
                        child: const Icon(
                          Icons.house_rounded,
                          color: Colors.white,
                          size: 80,
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'ULP',
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff14279B),
                          ),
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
                              keyboardType: TextInputType.emailAddress,
                              title: "Correo Electrónico",
                              validator: validateEmail,
                              hintText: 'Ingresa tu correo electrónico',
                              onSaved: (val) => email = val!,
                            ),
                            CustomTextFormField(
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
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xff14279B),
                            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                            textStyle: const TextStyle(fontSize: 20, color: Colors.white),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            minimumSize: const Size.fromHeight(50)),
                        child: const Text('Ingresar'),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            authProvider.authUser =
                                UserModel(id: 7, grupoId: 1, nombre: "Claudio Suarez", phone: "2664774140", email: "cssuarez689@gmail.com", password: "1234");

                            Navigator.pushReplacementNamed(context, '/profile');
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
                          onPressed: () {
                            print('olvidaste');
                          },
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
