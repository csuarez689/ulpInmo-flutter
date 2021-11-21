import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ulp_inmo/src/services/auth_service.dart';

class UserDisplayInfo extends StatelessWidget {
  final Color color;
  const UserDisplayInfo({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthService>(context).authUser;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _InfoDisplay(value: user!.nombre, title: 'Nombre'),
        _InfoDisplay(value: user.phone, title: 'Teléfono'),
        _InfoDisplay(value: user.email, title: 'Correo Electrónico'),
      ],
    );
  }
}

class _InfoDisplay extends StatelessWidget {
  final String value;
  final String title;
  const _InfoDisplay({Key? key, required this.value, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Color(0xff6b78c1)),
          ),
          const SizedBox(height: 1),
          Container(
              width: 350,
              height: 40,
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey, width: 1))),
              child: Text(value, style: const TextStyle(fontSize: 16, height: 1.4, color: Colors.black87))),
        ],
      ),
    );
  }
}
