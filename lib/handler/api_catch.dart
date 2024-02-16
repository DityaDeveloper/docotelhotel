import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

part '_payload_data.dart';

class ApiClient {
  final PayloadData payloadData = PayloadData();

  // ignore: unused_local_variable
  final headers = {
    "X-RapidAPI-Key": "",
    "X-RapidAPI-Host": "",
    "Bearer": "",
    "X-CSRF-Token": "",
  };

  Future post(
      {required pathUrl,
      required Map<String,String> requestBody,
      required String token}) async {
    final fullUrl = pathUrl;
    //const fullUrl = "http://localhost:8000/v1/api/login";
    Map<String, String> headers = {};
    if (token == '') {
      headers = {
        "Content-Type": "application/json"
        //"X-CSRF-Token": "",
      };
    } else {
      headers = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
        //"X-CSRF-Token": "",
      };
    }

    try {
     
      debugPrint('full url : $fullUrl , header : $headers, request : $requestBody');
      final response = await http.Client()
          .post(
        Uri.parse(fullUrl),
       headers: headers,
        body: jsonEncode(requestBody),
      )
          .timeout(const Duration(seconds: 10), onTimeout: () {
        debugPrint('Request Timeout');
        return http.Response('Request Timeout', 408);
      }).onError((error, stackTrace) {
        debugPrint('invalid connection');
        return http.Response('Internal Server Error', 500);
      });
      return payloadData.catchPayloadData(response);
    } finally {
      http.Client().close();
    }
  }

  Future get({required pathUrl, required String token}) async {
    final fullUrl =  pathUrl;
    Map<String, String> headers = {};
    if (token == '') {
      headers = {
        "Content-Type": "application/json"
        //"X-CSRF-Token": "",
      };
    } else {
      headers = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
        //"X-CSRF-Token": "",
      };
    }

    try {
      debugPrint('token : $token');
      debugPrint('url : $fullUrl');
      final response = await http.Client()
          .get(Uri.parse(fullUrl), headers: headers)
          .timeout(const Duration(seconds: 30), onTimeout: () {
        debugPrint('Request Timeout');
        return http.Response('Request Timeout', 408);
      }).onError((error, stackTrace) {
        debugPrint('invalid connection');
        return http.Response('Internal Server Error', 500);
      });
      return payloadData.catchPayloadData(response);
    } finally {
      http.Client().close();
    }
  }
}
