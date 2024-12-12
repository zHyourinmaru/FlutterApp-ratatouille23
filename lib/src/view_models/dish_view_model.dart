import 'package:ratatouille23/src/models/dish_model.dart';
import 'package:ratatouille23/src/service/dish_service.dart';
import 'package:ratatouille23/src/view_models/view_model.dart';

import '../service/api_status.dart';

class DishViewModel extends ViewModel {

  DishService service = DishService();

  List<DishModel> _totalDishes = [];
  List<DishModel> get totalDishes => _totalDishes;

  DishModel? _selectedDish;
  DishModel? get selectedDish => _selectedDish;

  DishModel? _dishToCreate;
  DishModel? get dishToCreate => _dishToCreate;

  _setTotalDishes(List<DishModel> value) {
    _totalDishes = value;
  }

  _setDishToCreate(DishModel value) {
    _dishToCreate = value;
  }

  _setSelectedDish(DishModel value) {
    _selectedDish = value;
  }

  createDish() async {
    if (dishToCreate != null) {
      if (dishToCreate?.name != "" && dishToCreate?.price != 0.0) {
        var response = await service.createDish(dishToCreate!);
        if (response is Success) {
          return response.response as int;
        } else if (response is Failure) {
          //onError(response.errorResponse as String);
        }
      }
    }
  }

  initDishToCreate() {
    _setDishToCreate(DishModel());
  }

  getDish(int id) async {
    var response = await service.getDish(id);
    if (response is Success) {
      _setSelectedDish(response.response as DishModel);
    } else if (response is Failure) {
      //onError(response.errorResponse as String);
    }
    notifyListeners();
  }

  getDishes() async {
    var response = await service.getDishes();
    if (response is Success) {
      _setTotalDishes(response.response as List<DishModel>);
    } else if (response is Failure) {
      //onError(response.errorResponse as String);
    }
    notifyListeners();
  }
}