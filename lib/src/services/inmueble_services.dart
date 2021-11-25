import 'package:ulp_inmo/src/models/inmueble_model.dart';
import 'package:ulp_inmo/src/services/http_service.dart';

class InmuebleService {
  final HttpService _http;

  InmuebleService(this._http);

  Future<List<InmuebleModel>?> getAll() async {
    final res = await _http.request<List<InmuebleModel>>(
      '/inmuebles/0',
      method: HttpMethod.get,
      parser: (json) => json.map<InmuebleModel>((item) => InmuebleModel.fromJson(item)).toList(),
    );
    return res.data;
  }

  Future<String?> update(InmuebleModel inmueble) async {
    final res = await _http.request('/inmuebles/${inmueble.id}', method: HttpMethod.put, body: inmueble.toJson());
    if (res.error != null) return 'Upss! Ha ocurrido un error!';
  }

  Future<String?> delete(int id) async {
    final res = await _http.request('/inmuebles/$id', method: HttpMethod.delete);
    if (res.error != null) return 'Upss! Ha ocurrido un error!';
  }

  Future<InmuebleModel?> create(InmuebleModel inmueble) async {
    final res = await _http.request<InmuebleModel>(
      '/inmuebles',
      method: HttpMethod.post,
      body: inmueble.toJson(),
      parser: (json) => InmuebleModel.fromJson(json),
    );
    return res.error != null ? null : res.data;
  }
}
