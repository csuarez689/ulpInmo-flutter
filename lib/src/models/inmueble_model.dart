import 'dart:math';

class InmuebleModel {
  InmuebleModel({
    required this.direccion,
    required this.superficie,
    required this.latitud,
    required this.longitud,
    this.id = 0,
  });
  late String direccion;
  late int superficie;
  late double latitud;
  late double longitud;
  late int id;

  InmuebleModel.fromJson(Map<String, dynamic> json) {
    direccion = json['direccion'];
    superficie = json['superficie'].toInt();
    latitud = json['latitud'].toDouble();
    longitud = json['longitud'].toDouble();
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['direccion'] = direccion;
    _data['superficie'] = superficie;
    _data['latitud'] = latitud;
    _data['longitud'] = longitud;
    _data['id'] = id;
    return _data;
  }

  String get imageUrl => 'assets/imgs/house_${Random().nextInt(3) + 1}.jpg';
}
