import 'dart:io';
import 'package:http/http.dart' as http;

abstract class MVVMService {
  http.Client client = http.Client();
}
