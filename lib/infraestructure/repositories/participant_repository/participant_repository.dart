


import 'package:gozalapp/domain/datasources/participant_datasource/participant_datasource.dart';
import 'package:gozalapp/domain/entities/participant/user.dart';
import 'package:gozalapp/domain/repositories/participant_repository/participant_repository.dart';

class ParticipantRepositoryImp extends ParticipantRepository {

  final ParticipantDatasource participantDatasource;

  ParticipantRepositoryImp(this.participantDatasource);

  @override
  Future<User> getUser() {
    return participantDatasource.getUser();
  }

}