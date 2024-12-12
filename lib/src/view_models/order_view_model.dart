import 'dart:ffi';

import 'package:ratatouille23/src/models/order_model.dart';
import 'package:ratatouille23/src/models/user_model.dart';
import 'package:ratatouille23/src/service/order_services.dart';
import 'package:ratatouille23/src/view_models/view_model.dart';

import '../service/api_status.dart';

class OrderViewModel extends ViewModel {
  final OrderService service = OrderService();

  List<OrderModel> _totalOrders = [];
  List<OrderModel> get totalOrders => _totalOrders;

  BigInt _totalMonthOrders = BigInt.from(0);
  BigInt get totalMonthOrders => _totalMonthOrders;

  BigInt _totalYearOrders = BigInt.from(0);
  BigInt get totalYearOrders => _totalYearOrders;

  double _totalMonthRevenues = 0.0;
  double get totalMonthRevenues => _totalMonthRevenues;

  double _totalYearRevenues = 0.0;
  double get totalYearRevenues => _totalYearRevenues;

  _setTotalOrders(List<OrderModel> totalOrders) {
    _totalOrders = totalOrders;
  }

  _setTotalMonthOrders(BigInt value) {
    _totalMonthOrders = value;
  }

  _setTotalYearOrders(BigInt value) {
    _totalYearOrders = value;
  }

  _setTotalMonthRevenues(double value) {
    _totalMonthRevenues = value;
  }

  _setTotalYearRevenues(double value) {
    _totalYearRevenues = value;
  }

  fetchTotalOrders({required DateTime time}) async {
    var response = await service.fetchNumberOfOrders(time: time);
    if (response is Success) {
      BigInt number = BigInt.from(response.response as int);
      DateTime now = DateTime.now();
      if (time == DateTime(now.year, now.month, 1)) {
        _setTotalMonthOrders(number);
      } else if (time == DateTime(now.year, 1, 1)) {
        _setTotalYearOrders(number);
      }
    } else if (response is Failure) {
      //onError(response.errorResponse as String);
    }
    notifyListeners();
  }

  fetchTotalRevenues({required DateTime time}) async {
    var response = await service.fetchRevenues(time: time);
    if (response is Success) {
      double revenues = response.response as double;
      DateTime now = DateTime.now();
      if (time == DateTime(now.year, now.month, 1)) {
        _setTotalMonthRevenues(revenues);
      } else if (time == DateTime(now.year, 1, 1)) {
        _setTotalYearRevenues(revenues);
      }
    } else if (response is Failure) {
      //onError(response.errorResponse as String);
    }
    notifyListeners();
  }

  getOrders() async {
    var response = await service.getOrders();
    if (response is Success) {
      _setTotalOrders(response.response as List<OrderModel>);
    } else if (response is Failure) {
      //onError(response.errorResponse as String);
    }
    notifyListeners();
  }
  
  fetchOrdersByTime(DateTime start, DateTime? end) async {
    var response = await service.fetchOrdersByTime(start, end);
    if (response is Success) {
      return response.response as List<OrderModel>;
    } else if (response is Failure) {
      //onError(response.errorResponse as String);
    }
    notifyListeners();
  }

  fetchOrdersByUser(BigInt userID) async {
    var response = await service.fetchOrdersByUser(userID);
    if (response is Success) {
      return response.response as List<OrderModel>;
    } else if (response is Failure) {
      //onError(response.errorResponse as String);
    }
    notifyListeners();
  }

}
