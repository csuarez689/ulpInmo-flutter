import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:ulp_inmo/src/models/user_model.dart';
import 'package:ulp_inmo/src/services/http_service.dart';

class AuthService with ChangeNotifier {
  UserModel? _authUser;
  final storage = const FlutterSecureStorage();
  final HttpService _http;

  AuthService(this._http);

  UserModel? get authUser => _authUser;

  set authUser(UserModel? user) {
    _authUser = user;
    notifyListeners();
  }

  Future<String?> login(String email, String password) async {
    final res = await _http.request<String>('/propietarios/login', method: HttpMethod.post, body: {'usuario': email, 'clave': password});

    if (res.error != null) {
      return res.statusCode == 400 ? 'Usuario o contraseña incorrectos' : 'Upss! Ha ocurrido un error!';
    }
    await storage.write(key: 'token', value: res.data);
    _http.addHeaders({'Authorization': 'Bearer ${res.data}'});
    return await getProfile();
  }

  Future<String?> getProfile() async {
    final res = await _http.request<UserModel>('/propietarios', method: HttpMethod.get, parser: (json) => UserModel.fromJson(json));
    if (res.error != null) return 'Upss! Ha ocurrido un error!';
    authUser = res.data;
  }

  Future<String?> updateProfile(UserModel user, String? clave) async {
    final res = await _http.request<UserModel>(
      '/propietarios/${_authUser!.id}',
      method: HttpMethod.put,
      body: {...user.toJson(), 'clave': clave},
      parser: (json) => UserModel.fromJson(json),
    );
    if (res.error != null) {
      return 'Upss! Ha ocurrido un error!';
    } else {
      authUser = res.data;
    }
  }

  void logout() async {
    await storage.deleteAll();
    _http.addHeaders({'Authorization': ''});
    authUser = null;
    notifyListeners();
  }

  Future<void> checkAuthUser() async {
    final token = await storage.read(key: 'token');
    if (token != null) {
      _http.addHeaders({'Authorization': 'Bearer $token'});
      await getProfile();
    }
  }
}
