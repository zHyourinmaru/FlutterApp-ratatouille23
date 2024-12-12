import 'dart:async';
import 'dart:io';

import '../service/api_status.dart';

mixin HandleApiExceptions {
  Future<Object> handleApiExceptions(
      Future<Object> Function() asyncFunction) async {
    try {
      return await asyncFunction();
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
