class UserModel {
  String nombre;
  String email;
  String telefono;
  int id;
  int grupoId;

  UserModel({
    required this.nombre,
    required this.email,
    required this.telefono,
    required this.id,
    required this.grupoId,
  });

  String get photoUrl => "https://ui-avatars.com/api/?color=14279B&name=$nombre&rounded=true&size=128";

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        nombre: json['nombre'],
        email: json['email'],
        telefono: json['telefono'],
        id: json['id'],
        grupoId: json['grupoId'],
      );

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nombre'] = nombre;
    _data['email'] = email;
    _data['telefono'] = telefono;
    _data['id'] = id;
    _data['grupoId'] = grupoId;
    return _data;
  }
}
