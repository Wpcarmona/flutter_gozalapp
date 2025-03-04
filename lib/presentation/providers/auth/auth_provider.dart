import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gozalapp/domain/entities/entities.dart';
import 'package:gozalapp/domain/repositories/auth_repository/auth_repository.dart';
import 'package:gozalapp/infraestructure/repositories/auth_repository/auth_repository.dart';
import 'package:gozalapp/presentation/infraestructure/services/key_value_storage_service.dart';
import 'package:gozalapp/presentation/infraestructure/services/key_value_storage_service_impl.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();
  final keyValueStorageService = KeyValueStorageServiceImpl();
  return AuthNotifier(
    authRepository: authRepository,
    keyValueStorageService: keyValueStorageService,
  );
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final KeyValueStorageService keyValueStorageService;

  AuthNotifier(
      {required this.authRepository, required this.keyValueStorageService})
      : super(AuthState()) {
    checkAuthStatus();
  }

  Future<void> loginUser(String numberDocument, String password) async {
    try {
      final user = await authRepository.login(
          numberDocument: numberDocument, password: password);
      _setLoggedUser(user);
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['data']['message'] ?? 'Error desconocido';
      state = state.copyWith(errorMessage: errorMessage);
    } catch (e) {
      print('error: $e');
    }
  }

  void registerUser(
      String email,
      String numberDocument,
      String typeDocument,
      String password,
      String passwordConfirmation,
      String numberPhone,
      String countryCode,
      String name,
      String day,
      String month,
      String year) async {
    try {
      final user = await authRepository.register(
          email: email,
          numberDocument: numberDocument,
          typeDocument: typeDocument,
          password: password,
          passwordConfirmation: passwordConfirmation,
          numberPhone: numberPhone,
          countryCode: countryCode,
          completeName: name,
          dateOfBirth: '$month/$day/$year');
      _setRegisterUser(user);
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['data']['message'] ?? 'Error desconocido';
      state = state.copyWith(errorMessage: errorMessage);
    } catch (e) {
      print('error: $e');
    }
  }

  Future<void> sendVerifyPhone(String userId) async {
    try {
      await authRepository.sendVerifyPhone(userId: userId);
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['data']['message'] ?? 'Error desconocido';
      state = state.copyWith(errorMessage: errorMessage);
    } catch (e) {
      print('error: $e');
    }
  }

  Future<void> verifyPhone(String code) async {
    try {
      String? userJson = await keyValueStorageService.getValue<String>('user');
      if (userJson != null) {
        Map<String, dynamic> userMap = jsonDecode(userJson);
        final response = await authRepository.verifyPhone(
            userId: userMap['uid'], code: code);
        _setVerifyPhone(response);
      }
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['data']['message'] ?? 'Error desconocido';
      state = state.copyWith(errorMessage: errorMessage);
    } catch (e) {
      print('error: $e');
    }
  }

  Future<void> updateUserTag(String tag) async {
    try {
      String? userJson = await keyValueStorageService.getValue<String>('user');
      String? token = await keyValueStorageService.getValue<String>('token');
      if (userJson != null && token != null) {
        Map<String, dynamic> userMap = jsonDecode(userJson);
        await authRepository.updateUserTag(
            token: token, userId: userMap['uid'], tag: tag);
        _setUpdateUser();
      }
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['data']['message'] ?? 'Error desconocido';
      state = state.copyWith(errorMessage: errorMessage);
    } catch (e) {
      print('error: $e');
    }
  }

  Future<void> logout([String? errorMessage]) async {
    final token = await keyValueStorageService.getValue<String>('token');
    if(token != null){
    await authRepository.logout(token: token);
    await keyValueStorageService.removeKey('token');
    await keyValueStorageService.removeKey('user');
    state = state.copyWith(
        authStatus: AuthStatus.notAuthenticated,
        user: null,
        errorMessage: errorMessage);
    }else{
      state = state.copyWith(
        authStatus: AuthStatus.notAuthenticated,
        user: null,
        errorMessage: errorMessage);
    }
   
  }

  void checkAuthStatus() async {
    final token = await keyValueStorageService.getValue<String>('token');
    if (token == null) return logout();
    state = state.copyWith(authStatus: AuthStatus.authenticated);
  }

  void _setVerifyPhone(VerifyPhone verifyPhone) async {
    await keyValueStorageService.setKeyValue<int>('stepRegister', 3);
    state = state.copyWith(authStatus: AuthStatus.chekingType);
  }

  void _setLoggedUser(Login login) async {
    await keyValueStorageService.setKeyValue('token', login.token);
    await keyValueStorageService.setKeyValue(
        'user',
        jsonEncode({
          '_id': login.participant.id,
          'email': login.participant.email,
          'name': login.participant.name,
          'avatar': login.participant.avatar,
          'uid': login.participant.uid,
          'uid_type': login.participant.uidType,
          'state': login.participant.state,
        }));
    // print('token1: ${await keyValueStorageService.getValue<String>('token')}');

    // String? userJson = await keyValueStorageService.getValue<String>('user');

    // if (userJson != null) {
    //   // Convertir el JSON a un Map
    //   Map<String, dynamic> userMap = jsonDecode(userJson);
    //   print('ID: ${userMap['_id']}');
    //   print('Email: ${userMap['email']}');
    //   print('Nombre: ${userMap['name']}');
    //   print('Avatar: ${userMap['avatar']}');
    //   print('UID: ${userMap['uid']}');
    //   print('Tipo de UID: ${userMap['uid_type']}');
    //   print('Estado: ${userMap['state']}');
    // } else {
    //   print('No se encontró ningún usuario almacenado.');
    // }
    state = state.copyWith(
      user: login.participant,
      authStatus: AuthStatus.authenticated,
    );
  }

  void _setRegisterUser(Register user) async {
    await keyValueStorageService.setKeyValue('token', user.token);
    await keyValueStorageService.setKeyValue<int>('stepRegister', 2);
    await keyValueStorageService.setKeyValue(
        'user',
        jsonEncode({
          '_id': user.participant.id,
          'email': user.participant.email,
          'name': user.participant.name,
          'avatar': user.participant.avatar,
          'uid': user.participant.uid,
          'uid_type': user.participant.uidType,
          'state': user.participant.state,
        }));
    sendVerifyPhone(user.participant.uid);
    state = state.copyWith(
      user: user.participant,
      authStatus: AuthStatus.chekingOTp,
    );
  }

  void _setUpdateUser() {
    state = state.copyWith(
      user: state.user,
      authStatus: AuthStatus.authenticated,
      errorMessage: '',
    );
  }
}

enum AuthStatus {
  checking,
  authenticated,
  notAuthenticated,
  chekingOTp,
  chekingType
}

class AuthState {
  final AuthStatus authStatus;
  final Participant? user;
  final String errorMessage;

  AuthState(
      {this.authStatus = AuthStatus.checking,
      this.user,
      this.errorMessage = ''});

  AuthState copyWith({
    AuthStatus? authStatus,
    Participant? user,
    String? errorMessage,
  }) =>
      AuthState(
          authStatus: authStatus ?? this.authStatus,
          user: user ?? this.user,
          errorMessage: errorMessage ?? this.errorMessage);
}
