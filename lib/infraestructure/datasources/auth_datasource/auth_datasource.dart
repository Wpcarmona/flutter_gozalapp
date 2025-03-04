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

  Register _jsonToRegister(Map<String, dynamic> json) {
    final registerResponse = CreateUserResponse.fromJson(json);
    return AuthMapper.registerToEntity(registerResponse);
  }

  SendVerifyPhone _jsonToSendVerifyPhone(Map<String, dynamic> json) {
    final sendVerifyPhoneResponse = SendVerifyPhoneResponse.fromJson(json);
    return AuthMapper.sendVerifyPhoneToEntity(sendVerifyPhoneResponse);
  }
  VerifyPhone _jsonToVerifyPhone(Map<String, dynamic> json) {
    final verifyPhoneResponse = VerifyPhoneResponse.fromJson(json);
    return AuthMapper.verifyPhoneToEntity(verifyPhoneResponse);
  }

  UpdateUser _jsonToUpdateUser(Map<String, dynamic> json) {
    final updateUserResponse = UpdateUserResponse.fromJson(json);
    return AuthMapper.updateUserTagToEntity(updateUserResponse);
  }
  
  @override
  Future<Login> login(
      {required String numberDocument, required String password}) async {
    final response = await dio.post(
      '/auth/login',
      data: {
        'numero_de_documento': numberDocument,
        'password': password,
      },
    );

    return _jsonToLogin(response.data);
  }

  @override
  Future<Logout> logout({required String token}) async {
    final response = await dio.post(
      '/auth/logout',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        }
      )
      );

    return _jsonToLogout(response.data);
  }
  
  @override
  Future<Register> register({
    required String email, 
    required String numberDocument, 
    required String typeDocument, 
    required String password, 
    required String passwordConfirmation, 
    required String numberPhone, 
    required String completeName, 
    required String countryCode, 
    required String dateOfBirth}) async {
    
    final response = await dio.post(
      '/users/create',
      data:{
        'properties' : {
          'email': email,
          'tipo_de_documento': numberDocument,
          'numero_de_documento': typeDocument,
          'password': password,
          'password_confirm': passwordConfirmation,
          'numero_de_celular': countryCode + numberPhone,
          'nombre_completo': completeName,
          'fecha_de_nacimiento': dateOfBirth,
        }
      }
    );
    return _jsonToRegister(response.data);
  }
  
  @override
  Future<SendVerifyPhone> sendVerifyPhone({required String userId}) async {
    final response = await  dio.post(
      '/validations/send_verify_phone',
      data: {
        'user_id': userId
      }
    );
    return _jsonToSendVerifyPhone(response.data);
  }
  
  @override
  Future<VerifyPhone> verifyPhone({required String userId, required String code}) async {
    final response = await dio.post(
      '/validations/verify_phone',
      data: {
        'user_id': userId,
        'code': code
      }
    );
    return _jsonToVerifyPhone(response.data);
  }
  
  @override
  Future<UpdateUser> updateUserTag({
    required String token, 
    required String userId,
    required String tag}) async {
    final response = await dio.post(
      '/users/update',
      data: {
        'user_id': userId,
        'properties': {
            'tags': tag
        },
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        }
      )
    );
    return _jsonToUpdateUser(response.data);
  }
}
