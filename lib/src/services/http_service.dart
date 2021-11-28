import 'dart:convert';
import 'package:http/http.dart';

import 'package:ulp_inmo/src/services/http_result.dart';

enum HttpMethod { get, post, put, patch, delete }

typedef Parser<T> = T Function(dynamic data);

class HttpService {
  final String baseUrl;
  final Map<String, String> _globalHeaders;

  HttpService(this.baseUrl, this._globalHeaders);

  Map<String, String> get globalHeaders => _globalHeaders;

  addHeaders(Map<String, String> headers) => _globalHeaders.addAll(headers);

  dynamic _encodeBody(dynamic body) {
    try {
      return jsonEncode(body);
    } catch (_) {
      return body;
    }
  }

  dynamic _decodeBody(String body) {
    try {
      return jsonDecode(body);
    } catch (_) {
      return body;
    }
  }

  Future<HttpResult<T>> request<T>(
    String path, {
    HttpMethod method = HttpMethod.get,
    Map<String, String> headers = const {},
    dynamic body,
    Parser<T>? parser,
    Duration timeout = const Duration(seconds: 10),
  }) async {
    int? statusCode;
    dynamic data;
    try {
      Uri url = Uri.parse('$baseUrl$path');
      final response = await sendRequest(url: url, method: method, headers: headers, body: body, timeout: timeout);
      data = _decodeBody(response.body);
      statusCode = response.statusCode;
      if (statusCode >= 400) {
        throw HttpError(data: data, stackTrace: StackTrace.current, exception: null);
      }
      return HttpResult<T>(data: parser == null ? data : parser(data), statusCode: statusCode, error: null);
    } catch (e, s) {
      if (e is HttpError) {
        return HttpResult<T>(data: null, statusCode: statusCode!, error: e);
      }
      return HttpResult<T>(data: null, statusCode: statusCode ?? -1, error: HttpError(data: data, exception: e, stackTrace: s));
    }
  }

  Future<Response> sendRequest({
    required Uri url,
    required HttpMethod method,
    required Map<String, String> headers,
    required dynamic body,
    required Duration timeout,
  }) {
    var finalHeaders = {..._globalHeaders, ...headers};
    if (method != HttpMethod.get) {
      body = _encodeBody(body);
    }
    final client = Client();
    switch (method) {
      case HttpMethod.get:
        return client.get(url, headers: finalHeaders).timeout(timeout);
      case HttpMethod.post:
        return client.post(url, headers: finalHeaders, body: body).timeout(timeout);
      case HttpMethod.put:
        return client.put(url, headers: finalHeaders, body: body).timeout(timeout);
      case HttpMethod.patch:
        return client.patch(url, headers: finalHeaders, body: body).timeout(timeout);
      case HttpMethod.delete:
        return client.delete(url, headers: finalHeaders, body: body).timeout(timeout);
    }
  }
}
