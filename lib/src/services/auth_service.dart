import 'package:flutter/material.dart';
import 'package:ulp_inmo/src/models/user_model.dart';

class AuthService with ChangeNotifier {
  UserModel? _authUser = UserModel(id: 7, grupoId: 1, nombre: "Claudio Suarez", phone: "2664774140", email: "cssuarez689@gmail.com", password: "1234");

  UserModel? get authUser => _authUser;

  set authUser(UserModel? user) {
    _authUser = user;
    notifyListeners();
  }
}
