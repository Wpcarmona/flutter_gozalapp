import 'package:gozalapp/domain/entities/entities.dart';

abstract class AuthDatasource {
  Future<Login> login({
    required String numberDocument,
    required String password
    });
  Future<Logout> logout();
}