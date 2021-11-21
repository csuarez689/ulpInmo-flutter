import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ulp_inmo/src/helpers/validators.dart';
import 'package:ulp_inmo/src/models/user_model.dart';
import 'package:ulp_inmo/src/services/auth_service.dart';
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
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          text: 'ULP',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff14279B),
                          ),
                          children: [
                            TextSpan(
                              text: 'Inmo',
                              style: TextStyle(color: Colors.black, fontSize: 30),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                      Form(
                        key: formKey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Text("Correo Electrónico", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) => validateEmail(value),
                                    obscureText: false,
                                    onSaved: (val) => email = val!,
                                    decoration: const InputDecoration(
                                      hintText: 'Ingresa tu correo electrónico',
                                      border: InputBorder.none,
                                      fillColor: Color(0xfff3f3f4),
                                      filled: true,
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
                                  const Text("Contraseña", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    validator: (value) => validateBetween(value),
                                    onSaved: (val) => password = val!,
                                    obscureText: obscurePassword,
                                    decoration: InputDecoration(
                                      hintText: 'Ingresa tu contraseña',
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
