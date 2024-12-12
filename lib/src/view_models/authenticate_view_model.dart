import 'package:ratatouille23/src/models/auth_model.dart';
import 'package:ratatouille23/src/secure_storage_service.dart';
import 'package:ratatouille23/src/service/api_status.dart';
import 'package:ratatouille23/src/service/authenticate_service.dart';
import 'package:ratatouille23/src/view_models/view_model.dart';

class AuthenticateViewModel extends ViewModel {
  final AuthenticationService service = AuthenticationService();

  AuthModel _authenticatingUser = AuthModel();
  AuthModel get authenticatingUser => _authenticatingUser;

  bool _authenticated = false;
  bool get authenticated => _authenticated;

  String email = "";

  setAuthenticatingUser(AuthModel authUser) {
    _authenticatingUser = authUser;
  }

  setAuthenticated(bool authenticated) {
    _authenticated = authenticated;
  }

  authenticate(void Function(String) onError) async {
    setLoading(true);
    var response = await service.authenticate(
        authenticatingUser.email, authenticatingUser.password);
    if (response is Success) {
      // Save token
      var token = response.response as String;
      await SecureStorageService.storage.write(key: "token", value: token);
      email = _authenticatingUser.email;
      _authenticatingUser = AuthModel();
      setAuthenticated(true);
    } else if (response is Failure) {
      print(response.errorResponse as String);
      // Throw error
      onError.call(response.errorResponse as String);
    }
    setLoading(false);
  }
}
