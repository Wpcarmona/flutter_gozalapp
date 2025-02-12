

import 'package:gozalapp/domain/datasources/auth_datasource/auth_datasource.dart';
import 'package:gozalapp/domain/entities/auth/login.dart';
import 'package:gozalapp/domain/entities/auth/logout.dart';
import 'package:gozalapp/domain/repositories/auth_repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {

  final AuthDatasource authDatasource;

  AuthRepositoryImpl(this.authDatasource);
  
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

}