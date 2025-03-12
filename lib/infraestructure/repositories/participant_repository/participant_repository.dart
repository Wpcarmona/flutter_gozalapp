


import 'package:gozalapp/domain/datasources/participant_datasource/participant_datasource.dart';
import 'package:gozalapp/domain/entities/participant/user.dart';
import 'package:gozalapp/domain/repositories/participant_repository/participant_repository.dart';
import 'package:gozalapp/infraestructure/datasources/infraestructure_datasource.dart';

class ParticipantRepositoryImp extends ParticipantRepository {

  final ParticipantDatasource participantDatasource;

  ParticipantRepositoryImp(
    [ParticipantDatasource? participantDatasource]
    ): participantDatasource = participantDatasource ?? ParticipantSPDatasource();

  @override
  Future<User> getUser(String token) {
    return participantDatasource.getUser(token);
  }

}