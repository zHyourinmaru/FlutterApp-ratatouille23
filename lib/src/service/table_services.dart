import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ratatouille23/src/secure_storage_service.dart';
import 'package:ratatouille23/src/service/mvvm_service.dart';

import '../api_constants.dart';
import 'api_status.dart';

class TableServices extends MVVMService {
  Future<Object> fetchTotalTableNumber() async {
    try {
      var token = await SecureStorageService.storage.read(key: "token");
      var response = await client.get(
          Uri.parse(ApiConstants.baseUrl +
              ApiConstants.tableEndPoint +
              ApiConstants.countEndPoint),
          headers: {ApiConstants.authHeader: "Bearer $token"});
      if (response.statusCode == 200) {
        return Success(
            code: 200, response: (BigInt.from(jsonDecode(response.body))));
      } else {
        return Failure(
          code: response.statusCode,
          errorResponse: jsonDecode(response.body),
        );
      }
      // Aggiungi altre eccezionei
    } on TimeoutException {
      return Failure(code: 101, errorResponse: "Connection Timeout!");
    } on HttpException {
      return Failure(code: 101, errorResponse: "No internet connection!");
    } on SocketException {
      return Failure(code: 101, errorResponse: "No internet connection!");
    } on FormatException {
      return Failure(code: 102, errorResponse: "Invalid Format!");
    } catch (e) {
      return Failure(code: 103, errorResponse: "Unknown error!");
    }
  }
}
