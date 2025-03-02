import 'package:gozalapp/domain/entities/entities.dart';

abstract class AuthRepository {
  Future<Login> login({
    required String numberDocument,
    required String password
    });


  Future<Logout> logout();

  Future<Register> register({
    required String email,
    required String numberDocument,
    required String typeDocument,
    required String password,
    required String passwordConfirmation,
    required String numberPhone,
    required String completeName,
    required String countryCode,
    required String dateOfBirth,
  });

  Future<SendVerifyPhone> sendVerifyPhone({
    required String userId
  });

  Future<VerifyPhone> verifyPhone({
    required String userId,
    required String code});
}