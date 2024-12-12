import 'package:ratatouille23/src/models/allergen_model.dart';
import 'package:ratatouille23/src/service/allergen_service.dart';
import 'package:ratatouille23/src/view_models/view_model.dart';

import '../service/api_status.dart';

class AllergenViewModel extends ViewModel {
  final AllergenService service = AllergenService();

  List<AllergenModel> _allergenModelList = [];
  List<AllergenModel> get allergenModelList => _allergenModelList;

  setAllergenModelList(List<AllergenModel> allergenModelList) {
    _allergenModelList = allergenModelList;
  }


  getAllergen(void Function(String errorMessage) onError) async {
    var response = await service.getAllergens();
    if (response is Success) {
      setAllergenModelList(response.response as List<AllergenModel>);
    } else if (response is Failure) {
      onError(response.errorResponse as String);
    }
    notifyListeners();
  }
}