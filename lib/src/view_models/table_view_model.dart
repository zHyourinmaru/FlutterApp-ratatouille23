import 'package:ratatouille23/src/service/table_services.dart';
import 'package:ratatouille23/src/view_models/view_model.dart';

import '../service/api_status.dart';

class TableViewModel extends ViewModel {
  final TableServices service = TableServices();

  BigInt _totalTableNumber = BigInt.from(0);
  BigInt get totalTableNumber => _totalTableNumber;

  setTotalTableNumber(BigInt number) {
    _totalTableNumber = number;
  }

  fetchTotalTableNumber() async {
    var response = await service.fetchTotalTableNumber();
    if (response is Success) {
      setTotalTableNumber(response.response as BigInt);
    } else if (response is Failure) {
      //onError(response.errorResponse as String);
    }
    notifyListeners();
  }
}
