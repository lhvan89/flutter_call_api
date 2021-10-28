import 'dart:async';
import 'dart:convert';
import 'package:flutter_call_api/services/response_serialization.dart';
import 'api_base_router.dart';

class ApiClient {

  ApiClient._instance();
  static final ApiClient instance = ApiClient._instance();

  Future<ServerResponse> request(
      {required ApiRouter router,
        required ResponseSerializable? target, bool isCache = false}) async {
    try {

      final response = await router.request();
      Map<String, dynamic>? json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final serverResponse = ServerResponse.parseJson(json, target);

        return serverResponse;
      } else {
        final msg = json?["Message"] ?? "Request server error";

        return ServerResponse(code: response.statusCode, message: msg);
      }
    } catch (e) {
      print(e.toString());
      return ServerResponse(code: 500, message: e.toString());
    }
  }

  Future<ServerResponseArray> requestArray(
      {required ApiRouter router,
        required ResponseSerializable? target, bool isCache = false}) async {
    try {

      final response = await router.request();
      Map<String, dynamic>? json = jsonDecode(response.body);
      if (response.statusCode == 200 && json != null) {
        final serverResponse = ServerResponseArray.parseJson(json, target);
        return serverResponse;
      } else {
        final msg = json?["Message"] ?? "Request server error";

        return ServerResponseArray(code: response.statusCode, message: msg);
      }
    } catch (e) {
      return ServerResponseArray(code: 500, message: e.toString());
    }
  }


}