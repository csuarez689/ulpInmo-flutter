import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ulp_inmo/src/models/user_model.dart';
import 'package:ulp_inmo/src/services/auth_service.dart';
import 'package:ulp_inmo/src/widgets/avatar_image.dart';
import 'package:ulp_inmo/src/widgets/stain_bg.dart';
import 'package:ulp_inmo/src/widgets/profile/user_change_password.dart';
import 'package:ulp_inmo/src/widgets/profile/user_display_info.dart';
import 'package:ulp_inmo/src/widgets/profile/user_edit_info.dart';

class ProfilePage extends StatefulWidget {
  final BuildContext context;
  ProfilePage(this.context);

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
    return Scaffold(
      body: Stack(
        children: <Widget>[
          StainBg(),
          SingleChildScrollView(
            child: Column(
              children: [
                SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: const Text(
                          "Mis Datos",
                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: Color(0xff14279B)),
                        ),
                      ),
                      _buildPopupMenu(),
                    ],
                  ),
                ),
                AvatarImage(
                  bgColor: accentColor,
                  imagePath: user.photoUrl,
                ),
                const SizedBox(height: 80),
                _getChild(),
              ],
            ),
          ),
        ],
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
      child: PopupMenuButton(
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
        return UserEditInfo();
      case 2:
        return UserChangePassword(user: user, onCommit: _goBack);
      default:
        return UserDisplayInfo(user: user, color: accentColor);
    }
  }

  void _goBack() {
    setState(() => selectedIndex = 0);
  }
}
