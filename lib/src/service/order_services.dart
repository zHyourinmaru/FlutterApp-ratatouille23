import "dart:async";
import "dart:convert";
import "dart:io";

import "package:intl/intl.dart";

import "../api_constants.dart";
import "../models/order_model.dart";
import "../secure_storage_service.dart";
import "api_status.dart";
import "mvvm_service.dart";


class OrderService extends MVVMService {

  Future<Object> fetchNumberOfOrders({required DateTime time}) async {
    try {
      String formattedDateTime = DateFormat("yyyy-MM-ddTHH:mm:ss").format(time);
      var queryParams = {"start": formattedDateTime};
      var token = await SecureStorageService.storage.read(key: "token");
      var uri = Uri.parse(ApiConstants.baseUrl +
          ApiConstants.orderEndPoint +
          ApiConstants.searchEndpoint)
          .replace(queryParameters: queryParams);
      var response = await client.get(
          uri,
          headers: {ApiConstants.authHeader: "Bearer $token"});
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        return Success(
            code: 200, response: jsonResponse.length);
      } else {
        print("failure");
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

  Future<Object> fetchRevenues({required DateTime time}) async {
    try {
      String formattedDateTime = DateFormat("yyyy-MM-ddTHH:mm:ss").format(time);
      var queryParams = {"start": formattedDateTime};
      var token = await SecureStorageService.storage.read(key: "token");
      var uri = Uri.parse(ApiConstants.baseUrl +
          ApiConstants.orderEndPoint +
          ApiConstants.searchEndpoint)
          .replace(queryParameters: queryParams);
      var response = await client.get(
          uri,
          headers: {ApiConstants.authHeader: "Bearer $token"});
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        List<OrderModel> orderList = jsonResponse.map((e) => OrderModel.fromJson(e)).toList();
        double revenues = orderList.fold(0, (previousValue, order) => previousValue + order.price);
        return Success(
            code: 200, response: revenues);
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

  getOrders() async {
    try {
      var token = await SecureStorageService.storage.read(key: "token");
      var response = await client.get(
          Uri.parse(ApiConstants.baseUrl +
              ApiConstants.orderEndPoint),
          headers: {ApiConstants.authHeader: "Bearer $token"});
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        List<OrderModel> orderList = jsonResponse.map((e) => OrderModel.fromJson(e)).toList();
        for (var value in orderList) {
          print(value.dishes);
        }
        return Success(
            code: 200, response: orderList);
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


  fetchOrdersByTime(DateTime start, DateTime? end) async {
    try {
      var token = await SecureStorageService.storage.read(key: "token");
      String formattedStart = DateFormat("yyyy-MM-ddTHH:mm:ss").format(start);
      var queryParams = {"start": formattedStart};
      if (end != null) {
        String formattedEnd = DateFormat("yyyy-MM-ddTHH:mm:ss").format(end);
        print(formattedEnd);
        queryParams["end"] = formattedEnd;
      }
      var uri = Uri.parse(ApiConstants.baseUrl +
          ApiConstants.orderEndPoint + ApiConstants.searchEndpoint).replace(queryParameters: queryParams);
      print(uri);
      var response = await client.get(
          uri,
          headers: {ApiConstants.authHeader: "Bearer $token"});
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        List<OrderModel> orderList = jsonResponse.map((e) => OrderModel.fromJson(e)).toList();
        return Success(
            code: 200, response: orderList);
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

  fetchOrdersByUser(BigInt userID) async {
    try {
      var token = await SecureStorageService.storage.read(key: "token");
      var uri = Uri.parse(ApiConstants.baseUrl +
          ApiConstants.userEndpoint + "/${userID}" + "/orders");
      print(uri);
      var response = await client.get(
          uri,
          headers: {ApiConstants.authHeader: "Bearer $token"});
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        List<OrderModel> orderList = jsonResponse.map((e) => OrderModel.fromJson(e)).toList();
        return Success(
            code: 200, response: orderList);
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
