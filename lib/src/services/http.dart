import 'dart:convert';
import 'package:http/http.dart';

import 'package:ulp_inmo/src/services/http_result.dart';

enum HttpMethod { get, post, put }

typedef Parser<T> = T Function(dynamic data);

class Http {
  final String baseUrl;

  Http({this.baseUrl = ''});

  dynamic _encodeBody(dynamic body) {
    try {
      jsonEncode(body);
    } catch (_) {
      return body;
    }
  }

  dynamic _decodeBody(String body) {
    try {
      jsonDecode(body);
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
      Uri url = (path.startsWith('http://') || path.startsWith('https://')) ? Uri.parse(path) : Uri.parse('$baseUrl$path');
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
      return HttpResult<T>(data: null, statusCode: -1, error: HttpError(data: data, exception: e, stackTrace: s));
    }
  }

  Future<Response> sendRequest({
    required Uri url,
    required HttpMethod method,
    required Map<String, String> headers,
    required dynamic body,
    required Duration timeout,
  }) {
    var finalHeaders = {...headers};
    if (method != HttpMethod.get) {
      final contentType = finalHeaders['Content-Type'];
      if (contentType == null || contentType.contains('application/json')) {
        finalHeaders['Content-Type'] = "application/json; charser=UTF-8";
        body = _encodeBody(body);
      }
    }
    final client = Client();
    switch (method) {
      case HttpMethod.get:
        return client.get(url, headers: finalHeaders).timeout(timeout);
      case HttpMethod.post:
        return client.post(url, headers: finalHeaders, body: body).timeout(timeout);
      case HttpMethod.put:
        return client.put(url, headers: finalHeaders, body: body).timeout(timeout);
    }
  }
}
