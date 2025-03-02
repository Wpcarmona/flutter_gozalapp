import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gozalapp/domain/entities/entities.dart';
import 'package:gozalapp/domain/repositories/auth_repository/auth_repository.dart';
import 'package:gozalapp/infraestructure/repositories/auth_repository/auth_repository.dart';


final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref){

  final authRepository = AuthRepositoryImpl();

  return AuthNotifier(authRepository: authRepository);

});


class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;

  AuthNotifier({required this.authRepository}) : super(AuthState());

  Future<void> loginUser(String numberDocument, String password) async {
    try {
      final  user = await authRepository.login(numberDocument: numberDocument, password: password);
      _setLoggedUser(user.participant);
    } on DioException catch (e) {
      final errorMessage = e.response?.data['data']['message'] ?? 'Error desconocido';
      state = state.copyWith(errorMessage: errorMessage);
    }
     catch (e) {
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
    String year
     ) async {
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
        dateOfBirth: '$month/$day/$year'
        ); 
      _setRegisterUser(user.participant, typeDocument); 
    } on DioException catch (e) {
      final errorMessage = e.response?.data['data']['message'] ?? 'Error desconocido';
      state = state.copyWith(errorMessage: errorMessage);
    }catch (e) {
      print('error: $e');
    }
  }

  Future<void> sendVerifyPhone(String userId) async {
    try {
      final response = await authRepository.sendVerifyPhone(userId: userId);
      _setSendVerifyPhone(response, userId);
    } on DioException catch (e) {
      final errorMessage = e.response?.data['data']['message'] ?? 'Error desconocido';
      state = state.copyWith(errorMessage: errorMessage);
    }
     catch (e) {
      print('error: $e');
    }
  }

  Future<void> verifyPhone(String code) async {
    try {
      // TODO: traer el numerDocument desde el guardado de la data
      final response = await authRepository.verifyPhone(userId: 'userId', code: code);
      _setVerifyPhone(response);
    } on DioException catch (e) {
      final errorMessage = e.response?.data['data']['message'] ?? 'Error desconocido';
      state = state.copyWith(errorMessage: errorMessage);
    }
     catch (e) {
      print('error: $e');
    }
  }

  void checkAuthStatus() async {
    
  }

  void _setSendVerifyPhone(SendVerifyPhone sendVerifyPhone, String userId) {
    print('sendVerifyPhone: $sendVerifyPhone');
  }
  void _setVerifyPhone(VerifyPhone verifyPhone) {
    print('verifyPhone: $verifyPhone');
  }

  void _setLoggedUser( Participant user) {
    state = state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
    );
  }

   void _setRegisterUser( Participant user, String numberDocument ) {
    sendVerifyPhone(numberDocument);
    state = state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
    );
  }

  Future<void> logout([ String? errorMessage ]) async {
    // TODO: limpiar token
    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
      errorMessage: errorMessage
    );
  }
}

enum AuthStatus { checking, authenticated, notAuthenticated }

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
