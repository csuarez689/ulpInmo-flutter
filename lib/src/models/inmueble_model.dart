class InmuebleModel {
  InmuebleModel({
    required this.direccion,
    required this.superficie,
    required this.latitud,
    required this.longitud,
    required this.id,
  });
  late final String direccion;
  late final int superficie;
  late final int latitud;
  late final int longitud;
  late final int id;

  InmuebleModel.fromJson(Map<String, dynamic> json) {
    direccion = json['direccion'];
    superficie = json['superficie'];
    latitud = json['latitud'];
    longitud = json['longitud'];
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
}
