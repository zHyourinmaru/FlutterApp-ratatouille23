import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ratatouille23/src/service/mvvm_service.dart';
import 'package:ratatouille23/src/utils/handle_exception_utils.dart';

import '../api_constants.dart';
import 'api_status.dart';

class AuthenticationService extends MVVMService with HandleApiExceptions {
  Future<Object> authenticate(String email, String password) async {
    try {
      var response = await client.post(
        headers: {"Content-Type": "application/json"},
        Uri.parse(ApiConstants.baseUrl + ApiConstants.authUrl),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      ).timeout(
        const Duration(seconds: 3),
      );
      if (response.statusCode == 200) {
        print("seeee");
        return Success(code: 200, response: jsonDecode(response.body)['token']);
      } else {
        return Failure(
            code: response.statusCode,
            errorResponse: jsonDecode(response.body)['message']);
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
