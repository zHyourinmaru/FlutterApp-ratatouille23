import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ratatouille23/src/models/dish_model.dart';

import '../api_constants.dart';
import '../secure_storage_service.dart';
import 'api_status.dart';
import 'mvvm_service.dart';

class DishService extends MVVMService {

  getDishes() async {
    try {
      var token = await SecureStorageService.storage.read(key: "token");
      var response = await client.get(
          Uri.parse(ApiConstants.baseUrl +
              ApiConstants.dishEndPoint),
          headers: {ApiConstants.authHeader: "Bearer $token"});
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        List<DishModel> dishList = jsonResponse.map((e) => DishModel.fromJson(e)).toList();
        return Success(
            code: 200, response: dishList);
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

  getDish(int id) async {
    try {
      var token = await SecureStorageService.storage.read(key: "token");
      var queryParams = {"id": id.toString()};
      var uri = Uri.parse(ApiConstants.baseUrl +
          ApiConstants.dishEndPoint)
          .replace(queryParameters: queryParams);
      print(uri);
      var response = await client.get(
          uri,
          headers: {ApiConstants.authHeader: "Bearer $token"});
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        DishModel dish = jsonResponse.map((e) => DishModel.fromJson(e)).toList().first;
        return Success(
            code: 200, response: dish);
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

  createDish(DishModel dish) async {
    try {
      var token = await SecureStorageService.storage.read(key: "token");
      var uri = Uri.parse(ApiConstants.baseUrl + ApiConstants.dishEndPoint);
      var response = await client.post(
          uri,
          headers: {
            ApiConstants.authHeader: "Bearer $token",
            "Content-Type": "application/json"
          },
          body: jsonEncode(dish));
      if (response.statusCode == 200) {
        return Success(
            code: 200, response: int.parse(response.body));
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