import 'package:gozalapp/domain/entities/entities.dart';

abstract class ParticipantRepository {
  Future<User> getUser(String token);
}