import 'package:auth_firebase/auth/models/old_login_request_model.dart';
import 'package:auth_firebase/auth/models/old_login_response_model.dart';
import 'package:auth_firebase/auth/models/old_register_request_model.dart';
import 'package:auth_firebase/auth/models/old_register_response_model.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

/// LoginService responsible to communicate with web-server
/// via authenticaton related APIs
class LoginService extends GetConnect {
  final String loginUrl = 'https://reqres.in/api/login';
  final String registerUrl = 'https://reqres.in/api/register';

  Future<LoginResponseModel?> fetchLogin(LoginRequestModel model) async {
    final response = await post(loginUrl, model.toJson());

    if (response.statusCode == null) {
      return LoginResponseModel.fromFake();
    }

    if (response.statusCode == HttpStatus.ok) {
      return LoginResponseModel.fromJson(response.body);
    } else {
      return null;
    }
  }

  Future<RegisterResponseModel?> fetchRegister(
      RegisterRequestModel model) async {
    final response = await post(registerUrl, model.toJson());

    //JMD - Fake response
    if (response.statusCode == null) {
      return RegisterResponseModel.fromFake();
    }

    if (response.statusCode == HttpStatus.ok) {
      return RegisterResponseModel.fromJson(response.body);
    } else {
      return null;
    }
  }
}
