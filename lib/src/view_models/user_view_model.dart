import 'package:get/get.dart';
import 'package:ratatouille23/src/models/user_model.dart';
import 'package:ratatouille23/src/service/api_status.dart';
import 'package:ratatouille23/src/service/user_services.dart';
import 'package:ratatouille23/src/view_models/view_model.dart';

import '../models/role.dart';

class UserViewModel extends ViewModel {
  final UserServices service = UserServices();

  List<UserModel> _userListModel = [];
  List<UserModel> get userListMode => _userListModel;

  BigInt _totalEmployeeCount = BigInt.from(0);
  BigInt get totalEmployeeCount => _totalEmployeeCount;

  BigInt _supervisorsCount = BigInt.from(0);
  BigInt get supervisorsCount => _supervisorsCount;

  BigInt _waitersCount = BigInt.from(0);
  BigInt get waitersCount => _waitersCount;

  BigInt _cookersCount = BigInt.from(0);
  BigInt get cookersCount => _cookersCount;

  UserModel? _userToCreate;
  UserModel? get userToCreate => _userToCreate;

  setUserToCreate(UserModel user) {
    _userToCreate = user;
  }

  initUserToCreate() {
    setUserToCreate(UserModel());
  }

  setUserListModel(List<UserModel> userListModel) {
    _userListModel = userListModel;
  }

  setTotalEmployeeCount(BigInt value) {
    _totalEmployeeCount = value;
  }

  setSupervisorsCount(BigInt value) {
    _supervisorsCount = value;
  }

  setWaitersCount(BigInt value) {
    _waitersCount = value;
  }

  setCookersCount(BigInt value) {
    _cookersCount = value;
  }

  getTotalEmployeeCount({Role? role}) async {
    var response = await service.getTotalEmployeeCount(role: role);
    if (response is Success) {
      BigInt value = response.response as BigInt;

      switch (role) {
        case Role.SUPERVISOR:
          setSupervisorsCount(value);
          break;
        case Role.WAITER:
          setWaitersCount(value);
          break;
        case Role.COOK:
          setCookersCount(value);
          break;
        default:
          setTotalEmployeeCount(value);
      }
    } else {
      print("CANNOT GET TOTAL EMPLOYEE of role" + role.toString());
    }
    notifyListeners();
  }

  getUsers(void Function(String errorMessage) onError) async {
    var response = await service.getUsers();
    if (response is Success) {
      setUserListModel(response.response as List<UserModel>);
    } else if (response is Failure) {
      onError(response.errorResponse as String);
    }
    notifyListeners();
  }


  createUser() async {
    if (userToCreate != null) {
      if (userToCreate?.firstName != "" && userToCreate?.email != "") {
        var response = await service.createUser(userToCreate!);
        if (response is Success) {
          return response.response as BigInt;
        } else if (response is Failure) {
          //onError(response.errorResponse as String);
        }
      }
    }
    notifyListeners();
  }
}
