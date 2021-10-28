import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import 'dart:io';
import 'package:flutter/material.dart';

enum Method { Post, Put, Get, Delete }

abstract class ApiRouter {
  static final ROOT_URL = 'https://reqres.in';
  final baseUrl = '${ROOT_URL}/api/';
  final timeOut = Duration(seconds: 30);

  late String _path;
  late Method _method;
  Map<String, dynamic>? _params;
  File? _file;
  bool resizeImage;

  ApiRouter({required String path, Method method = Method.Post, Object? params, File? file, this.resizeImage = false}) {
    this._path = path;
    this._method = method;
    this._params = params as Map<String, dynamic>;
    this._file = file;
  }

  String get path => _path;
  Map<String, dynamic>? get params => _params;
  Method get method => _method;
  File? get file => _file;

  Map<String, dynamic> getHeaders() {
    var headers = {"Content-Type": "application/json"};
    return headers;
  }

  Future<Response> request() async {
    final client = http.Client();
    final url = baseUrl + this.path;
    final params = this.params;
    try {
      final headers = getHeaders();
      var response;
      if (this.method == Method.Get) {
        var request;
        if (params != null) {
          request = url + "?" + Uri(queryParameters: params.map((key, value) => MapEntry(key, value?.toString()))).query;
        } else {
          request = url;
        }
        response = await client.get(Uri.parse(request), headers: headers as Map<String, String>).timeout(timeOut, onTimeout: () {
          throw TimeoutException('The connection has timed out, Please try again!');
        });
      } else {
        final body = jsonEncode(params);
        response = await client.post(Uri.parse(url), headers: headers as Map<String, String>, body: body).timeout(timeOut, onTimeout: (){
          throw TimeoutException('The connection has timed out, Please try again!');
        });
      }
      debugPrint("response: ${response.body}");
      return response;
    } catch (e) {
      debugPrint("error: ${e.toString()}");
      throw e;
    }
  }
}