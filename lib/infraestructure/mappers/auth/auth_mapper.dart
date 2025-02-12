

import 'package:gozalapp/domain/entities/entities.dart';
import 'package:gozalapp/infraestructure/models/models.dart';

class AuthMapper {
  static Login loginToEntity(LoginResponse login) => Login(
    ok: login.ok,
    token: login.token,
    participant: Participant(
      id: login.participant.id, 
      email: login.participant.email, 
      name: login.participant.name, 
      avatar: login.participant.avatar,
      uid: login.participant.uid, 
      uidType: login.participant.uidType, 
      state: login.participant.state
      ),
      message: login.message
  );

  static Logout logoutToEntity(LogoutResponse logout) => Logout(
    ok: logout.ok, message: logout.message);
}