import 'dart:math';

class InmuebleModel {
  String direccion;
  int superficie;
  double latitud;
  double longitud;
  int propietarioId;
  int grupoId;
  int id;
  dynamic propietario;
  late String imageUrl;

  InmuebleModel({
    required this.direccion,
    required this.superficie,
    required this.latitud,
    required this.longitud,
    this.propietarioId = 0,
    this.grupoId = 0,
    this.id = 0,
  }) {
    imageUrl = _randomImage;
  }

  factory InmuebleModel.fromJson(Map<String, dynamic> json) {
    return InmuebleModel(
      direccion: json['direccion'],
      superficie: json['superficie'].toInt(),
      latitud: json['latitud'].toDouble(),
      longitud: json['longitud'].toDouble(),
      propietarioId: json['propietarioId'].toInt(),
      grupoId: json['grupoId'].toInt(),
      id: json['id'].toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['direccion'] = direccion;
    data['superficie'] = superficie;
    data['latitud'] = latitud;
    data['longitud'] = longitud;
    data['propietarioId'] = propietarioId;
    data['grupoId'] = grupoId;
    data['id'] = id;
    imageUrl = _randomImage;
    return data;
  }

  String get _randomImage => 'assets/imgs/house_${Random().nextInt(3) + 1}.jpg';
}
