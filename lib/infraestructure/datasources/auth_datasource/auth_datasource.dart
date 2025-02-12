import 'package:gozalapp/config/constants/environment.dart';
import 'package:gozalapp/domain/datasources/auth_datasource/auth_datasource.dart';
import 'package:gozalapp/domain/entities/entities.dart';
import 'package:gozalapp/infraestructure/mappers/mappers.dart';
import 'package:gozalapp/infraestructure/models/models.dart';
import 'package:dio/dio.dart';

class AuthSPDatasource extends AuthDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: Environment.baseUrl,
  ));

  Login _jsonToLogin(Map<String, dynamic> json) {
    final loginResponse = LoginResponse.fromJson(json);

    return AuthMapper.loginToEntity(loginResponse);
  }

  Logout _jsonToLogout(Map<String, dynamic> json) {
    final logoutResponse = LogoutResponse.fromJson(json);
    return AuthMapper.logoutToEntity(logoutResponse);
  }
  
  @override
  Future<Login> login(
      {required String numberDocument, required String password}) async {
    final response = await dio.post(
      '/auth/login',
      data: {
        'numberDocument': numberDocument,
        'password': password,
      },
    );

    return _jsonToLogin(response.data);
  }

  @override
  Future<Logout> logout() async {
    final response = await dio.post(
      '/auth/logout',
      options: Options(
        headers: {
          'Authorization': 'Bearer 123', //TODO agregar el header desde el isar
        }
      )
      );

    return _jsonToLogout(response.data);
  }
}
