import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  static final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
}
