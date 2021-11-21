class UserModel {
  String nombre;
  String email;
  String? password;
  int id;
  int grupoId;
  String phone;

  UserModel({
    required this.nombre,
    required this.email,
    required this.password,
    required this.id,
    required this.grupoId,
    required this.phone,
  });

  String get photoUrl => "https://ui-avatars.com/api/?color=14279B&name=$nombre&rounded=true&size=128";
}
