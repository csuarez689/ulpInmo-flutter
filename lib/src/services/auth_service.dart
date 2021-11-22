import 'package:flutter/material.dart';
import 'package:ulp_inmo/src/models/user_model.dart';
import 'package:ulp_inmo/src/services/http.dart';

class AuthService with ChangeNotifier {
  UserModel? _authUser;
  final Http _http;

  AuthService(this._http);

  UserModel? get authUser => _authUser;

  set authUser(UserModel? user) {
    _authUser = user;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    final res = await _http.request('/Propietarios/login', method: HttpMethod.get, body: {'email': email, 'password': password});
    print("result data ${res.data}");
    print("result data runtime ${res.data.runtimeType}");
    print("result data error ${res.error}");
    print("result data statusCode ${res.statusCode}");
  }
}
