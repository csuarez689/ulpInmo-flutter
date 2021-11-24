import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ulp_inmo/src/models/user_model.dart';
import 'package:ulp_inmo/src/services/auth_service.dart';
import 'package:ulp_inmo/src/widgets/avatar_image.dart';
import 'package:ulp_inmo/src/widgets/main_scaffold.dart';
import 'package:ulp_inmo/src/widgets/profile/user_change_password.dart';
import 'package:ulp_inmo/src/widgets/profile/user_display_info.dart';
import 'package:ulp_inmo/src/widgets/profile/user_edit_info.dart';

class ProfilePage extends StatefulWidget {
  final BuildContext context;
  const ProfilePage(this.context, {Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final accentColor = Colors.pink.withOpacity(.9);
  late UserModel user;
  late int selectedIndex;

  @override
  void initState() {
    selectedIndex = 0;
    user = Provider.of<AuthService>(widget.context).authUser!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthService>(context).authUser;

    return MainScaffold(
      navIndex: 1,
      navActions: [_buildPopupMenu()],
      title: const Text(
        "Mis Datos",
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white),
      ),
      child: WillPopScope(
        onWillPop: () async {
          if (selectedIndex == 0) {
            return true;
          } else {
            setState(() => selectedIndex = 0);
            return false;
          }
        },
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                SafeArea(child: Container(margin: const EdgeInsets.only(top: 30), child: AvatarImage(imagePath: user!.photoUrl))),
                const SizedBox(height: 60),
                AnimatedSwitcher(
                  child: _getChild(),
                  duration: const Duration(milliseconds: 300),
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return SlideTransition(
                      position: Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(animation),
                      child: child,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPopupMenu() {
    return Container(
      width: 35,
      height: 35,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      margin: const EdgeInsets.only(right: 20, top: 10),
      child: PopupMenuButton(
        elevation: 4,
        icon: Icon(Icons.edit, color: accentColor, size: 22),
        padding: const EdgeInsets.all(0),
        itemBuilder: (context) => [
          PopupMenuItem<int>(value: 2, child: Text("Cambiar Contraseña", style: TextStyle(color: selectedIndex == 2 ? accentColor : Colors.black))),
          PopupMenuItem<int>(value: 1, child: Text("Editar Información", style: TextStyle(color: selectedIndex == 1 ? accentColor : Colors.black))),
          PopupMenuItem<int>(value: 0, child: Text("Mi Información", style: TextStyle(color: selectedIndex == 0 ? accentColor : Colors.black))),
        ],
        onSelected: (int item) {
          if (item != selectedIndex) setState(() => selectedIndex = item);
        },
      ),
    );
  }

  Widget _getChild() {
    switch (selectedIndex) {
      case 1:
        return UserEditInfo(title: "Editar Información", color: accentColor);
      case 2:
        return UserChangePassword(title: "Cambiar Contraseña", color: accentColor);
      default:
        return UserDisplayInfo(color: accentColor);
    }
  }
}
