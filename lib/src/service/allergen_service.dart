import 'dart:convert';

import 'package:ratatouille23/src/models/allergen_model.dart';
import 'package:ratatouille23/src/service/mvvm_service.dart';
import 'package:ratatouille23/src/utils/handle_exception_utils.dart';

import '../api_constants.dart';
import '../secure_storage_service.dart';
import 'api_status.dart';

class AllergenService extends MVVMService with HandleApiExceptions {
  Future<Object> getAllergens() async {
    return handleApiExceptions(() async {
      var token = await SecureStorageService.storage.read(key: "token");
      var response = await client.get(
          Uri.parse(ApiConstants.baseUrl + ApiConstants.allergenEndPoint),
          headers: {ApiConstants.authHeader: "Bearer $token"});
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        List<AllergenModel> allergenList = List.from(jsonResponse.map((element) {
          return AllergenModel.fromJson(element);
        }));
        return Success(
          code: 200,
          response: allergenList,
        );
      } else {
        return Failure(
            code: response.statusCode,
            errorResponse: jsonDecode(response.body)['message']);
      }
    });
  }
}