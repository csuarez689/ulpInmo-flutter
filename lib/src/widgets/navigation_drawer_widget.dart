import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ulp_inmo/src/models/user_model.dart';
import 'package:ulp_inmo/src/services/auth_service.dart';
import 'package:ulp_inmo/src/widgets/avatar_image.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthService>(context).authUser!;
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(.9),
              Theme.of(context).colorScheme.primary.withOpacity(.6),
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: <Widget>[
                  const SizedBox(height: 50),
                  _Header(user),
                  const Divider(color: Colors.white70, height: 50),
                  _MenuItem(text: 'Mis Datos', icon: Icons.person_pin, selected: true, onTap: () {}),
                  const SizedBox(height: 16),
                  _MenuItem(text: 'Mis Propiedades', icon: Icons.business_rounded, onTap: () {}),
                  const SizedBox(height: 16),
                  _MenuItem(text: 'Contacto', icon: Icons.call_rounded, onTap: () {}),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            const Divider(color: Colors.white70),
            _MenuItem(text: 'Cerrar Sesión', icon: Icons.exit_to_app, onTap: () {}),
          ],
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;
  final bool selected;
  const _MenuItem({Key? key, required this.icon, required this.onTap, required this.text, this.selected = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        selected: selected,
        leading: Icon(icon, color: Colors.white),
        title: Text(text, style: const TextStyle(color: Colors.white)),
        hoverColor: Colors.white70,
        onTap: onTap,
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final UserModel user;
  const _Header(this.user);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            AvatarImage(imagePath: user.photoUrl, radius: 35),
            SizedBox(
              width: 180,
              child: Column(
                children: [
                  Text(user.nombre, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text(user.email, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w300, color: Colors.white54)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
