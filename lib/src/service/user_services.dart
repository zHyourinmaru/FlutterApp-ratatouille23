import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ratatouille23/src/api_constants.dart';
import 'package:ratatouille23/src/models/user_model.dart';
import 'package:ratatouille23/src/secure_storage_service.dart';
import 'package:ratatouille23/src/service/mvvm_service.dart';
import 'package:ratatouille23/src/utils/handle_exception_utils.dart';

import '../models/role.dart';
import 'api_status.dart';

class UserServices extends MVVMService with HandleApiExceptions {

  Future<Object> getTotalEmployeeCount({Role? role}) async {
    try {
      var queryParams = {
        "role": role?.name,
      };
      var token = await SecureStorageService.storage.read(key: "token");
      var response = await client.get(
          Uri.parse(ApiConstants.baseUrl +
                  ApiConstants.userEndpoint +
                  ApiConstants.countEndPoint)
              .replace(queryParameters: queryParams),
          headers: {ApiConstants.authHeader: "Bearer $token"});
      if (response.statusCode == 200) {
        return Success(
            code: 200,
            response: BigInt.from(jsonDecode(response.body))
        );
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

  Future<Object> getUsers() async {
    return handleApiExceptions(() async {
      var token = await SecureStorageService.storage.read(key: "token");
      var response = await client.get(
          Uri.parse(ApiConstants.baseUrl + ApiConstants.userEndpoint),
          headers: {ApiConstants.authHeader: "Bearer $token"});
      if (response.statusCode == 200) {
        var jsonReponse = jsonDecode(response.body);
        List<UserModel> userList = List.from(jsonReponse.map((element) {
          return UserModel.fromJson(element);
        }));
        return Success(
          code: 200,
          response: userList,
        );
      } else {
        return Failure(
            code: response.statusCode,
            errorResponse: jsonDecode(response.body)['message']);
      }
    });
  }

  createUser(UserModel user) async {
    try {
      var token = await SecureStorageService.storage.read(key: "token");
      var uri = Uri.parse(ApiConstants.baseUrl +
          ApiConstants.userEndpoint);
      var response = await client.post(
          uri,
          headers: {
            ApiConstants.authHeader: "Bearer $token",
            "Content-Type": "application/json"
          }, body: jsonEncode(user));
      if (response.statusCode == 200) {
        return Success(
            code: 200,
            response: BigInt.from(jsonDecode(response.body))
        );
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
