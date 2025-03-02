

import 'package:gozalapp/domain/datasources/auth_datasource/auth_datasource.dart';
import 'package:gozalapp/domain/entities/entities.dart';
import 'package:gozalapp/domain/repositories/auth_repository/auth_repository.dart';
import 'package:gozalapp/infraestructure/datasources/auth_datasource/auth_datasource.dart';

class AuthRepositoryImpl extends AuthRepository {

  final AuthDatasource authDatasource;
  

  AuthRepositoryImpl(
    [AuthDatasource? authDatasource]
    ): authDatasource = authDatasource ?? AuthSPDatasource();
  
  @override
  Future<Login> login({required String numberDocument, required String password}) {
    
    return authDatasource.login(
      numberDocument: numberDocument, 
      password: password
      );
  }

  @override
  Future<Logout> logout() {
    return authDatasource.logout();
  }

  @override
  Future<Register> register({required String email,required String numberDocument, required String typeDocument, required String password, required String passwordConfirmation, required String numberPhone, required String completeName, required String countryCode, required String dateOfBirth}) {
    return authDatasource.register(email: email, numberDocument: numberDocument, typeDocument: typeDocument, password: password, passwordConfirmation: passwordConfirmation, numberPhone: numberPhone, completeName: completeName, countryCode: countryCode, dateOfBirth: dateOfBirth);
  }

  @override
  Future<SendVerifyPhone> sendVerifyPhone({required String userId}) {
    return authDatasource.sendVerifyPhone(userId: userId);
  }

  @override
  Future<VerifyPhone> verifyPhone({required String userId, required String code}) {
    return authDatasource.verifyPhone(userId: userId, code: code);
  }

}