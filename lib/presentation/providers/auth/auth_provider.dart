import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gozalapp/domain/entities/entities.dart';
import 'package:gozalapp/domain/repositories/domain_repository.dart';
import 'package:gozalapp/infraestructure/repositories/infraestructure_repository.dart';
import 'package:gozalapp/presentation/infraestructure/services/key_value_storage_service.dart';
import 'package:gozalapp/presentation/infraestructure/services/key_value_storage_service_impl.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();
  final keyValueStorageService = KeyValueStorageServiceImpl();
  final participantRepository = ParticipantRepositoryImp();
  return AuthNotifier(
    authRepository: authRepository,
    keyValueStorageService: keyValueStorageService,
    participantRepository: participantRepository,
  );
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final ParticipantRepository participantRepository;
  final KeyValueStorageService keyValueStorageService;

  AuthNotifier({
        required this.authRepository, 
        required this.keyValueStorageService,
        required this.participantRepository
      })
      : super(AuthState()) {
    checkAuthStatus();
  }

  Future<void> loginUser(String numberDocument, String password) async {
  try {
    final user = await authRepository.login(
        numberDocument: numberDocument, password: password);
    _setLoggedUser(user);
  } on DioException catch (e) {
    final responseData = e.response?.data;
    if (responseData is Map<String, dynamic>) {
      final errorData = responseData['data'];
      if (errorData is Map<String, dynamic> && errorData.containsKey('message')) {
        state = state.copyWith(errorMessage: errorData['message']);
      } else {
        state = state.copyWith(errorMessage: 'Error desconocido');
      }
    } else {
      state = state.copyWith(errorMessage: 'Error inesperado en la respuesta');
    }
  } catch (e) {
    print('error: $e');
  }
}

Future<void> getParticipant(String token) async {

  try {
    final participant = await participantRepository.getUser(token);
   _setInfoParticipant(participant);
  } on DioException catch (e) {
    final responseData = e.response?.data;
    if (responseData is Map<String, dynamic>) {
      final errorData = responseData['data'];
      if (errorData is Map<String, dynamic> && errorData.containsKey('message')) {
        state = state.copyWith(errorMessage: errorData['message']);
      } else {
        state = state.copyWith(errorMessage: 'Error desconocido');
      }
    } else {
      state = state.copyWith(errorMessage: 'Error inesperado en la respuesta');
    }
  } catch (e) {
    print('errorinParticipant: $e');
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

  Future<void> resendVerifyPhone() async {
    String? userJson = await keyValueStorageService.getValue<String>('user');
      if (userJson != null) {
        Map<String, dynamic> userMap = jsonDecode(userJson);
        await sendVerifyPhone(userMap['uid']);
    }
  }

  Future<void> sendVerifyPhone(String userId) async {
    try {
      await authRepository.sendVerifyPhone(userId: userId);
      // _setSendVerifyPhone();
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
    await keyValueStorageService.removeKey('userInfo');
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

  void _setSendVerifyPhone() async {
    state = state.copyWith(
      errorMessage: '',
      );
  }

void _setInfoParticipant(User user) async {
  try {
    await keyValueStorageService.setKeyValue(
    'userInfo', 
    jsonEncode({
    'uid': user.user.uid,
    'uid_type': user.user.uidType,
    'email': user.user.email,
    'points': user.user.points,
    'total_points': user.user.totalPoints,
    'coins': user.user.coins,
    'total_coins': user.user.totalCoins,
    'state': user.user.state,
    'bad_email': user.user.badEmail,
    'email_verified': user.user.emailVerified,
    'cellphone_verified': user.user.cellphoneVerified,
    'unconfirmed_email': user.user.unconfirmedEmail,
    'unconfirmed_cellphone': user.user.unconfirmedCellphone,
    'avatar': user.user.avatar,
    'last_activity_at': user.user.lastActivityAt.toString(),
    'nombre_completo': user.user.nombreCompleto,
    'ccode': user.user.numeroDeCelular.ccode,
    'numero_de_celular': user.user.numeroDeCelular.number,
    'tipo_de_documento': user.user.tipoDeDocumento,
    'numero_de_documento': user.user.numeroDeDocumento,
    'tags': user.user.tags,
    'aceptar_terminos': user.user.aceptarTerminos,
  }));
  } catch (e) {
    print('error: $e');
  }
  

}


  void _setVerifyPhone(VerifyPhone verifyPhone) async {
    await keyValueStorageService.setKeyValue<int>('stepRegister', 3);
    state = state.copyWith(
      authStatus: AuthStatus.chekingType,
      errorMessage: '',
      );
  }

  void _setLoggedUser(Login login) async {
    await keyValueStorageService.setKeyValue('token', login.token);
    // await keyValueStorageService.setKeyValue(
    //     'user',
    //     jsonEncode({
    //       '_id': login.participant.id,
    //       'email': login.participant.email,
    //       'name': login.participant.name,
    //       'avatar': login.participant.avatar,
    //       'uid': login.participant.uid,
    //       'uid_type': login.participant.uidType,
    //       'state': login.participant.state,
    //     }));
    await getParticipant(login.token);
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
    state = state.copyWith(
      user: user.participant,
      authStatus: AuthStatus.chekingOTp,
      errorMessage: '',
    );
    sendVerifyPhone(user.participant.uid);
  }

  void _setUpdateUser() {
    state = state.copyWith(
      user: state.user,
      authStatus: AuthStatus.authenticated,
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
