import 'package:gozalapp/domain/entities/entities.dart';

abstract class ParticipantDatasource {
  Future<User> getUser(String token);
}