class UserModel {
  UserModel({
    required this.nombre,
    required this.email,
    required this.telefono,
    required this.id,
    required this.grupoId,
  });
  late String nombre;
  late String email;
  late String telefono;
  late int id;
  late int grupoId;

  String get photoUrl => "https://ui-avatars.com/api/?color=14279B&name=$nombre&rounded=true&size=128";

  UserModel.fromJson(Map<String, dynamic> json) {
    nombre = json['nombre'];
    email = json['email'];
    telefono = json['telefono'];
    id = json['id'];
    grupoId = json['grupoId'];
  }

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
