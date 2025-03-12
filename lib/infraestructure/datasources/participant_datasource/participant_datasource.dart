


import 'package:gozalapp/config/constants/environment.dart';
import 'package:gozalapp/domain/datasources/domain_datasource.dart';
import 'package:gozalapp/domain/entities/participant/user.dart';
import 'package:dio/dio.dart';
import 'package:gozalapp/domain/entities/entities.dart';
import 'package:gozalapp/infraestructure/mappers/mappers.dart';
import 'package:gozalapp/infraestructure/models/participant/participant.dart';
class ParticipantSPDatasource extends ParticipantDatasource{
  final dio = Dio(BaseOptions(
    baseUrl: Environment.baseUrl,
  ));

 User _jsonToUser(Map<String, dynamic> json) {
  final userResponse = ParticipantResponse.fromJson(json);
  return ParticipantMapper.participantToEntity(userResponse);
}

  @override
  Future<User> getUser(String token) async {
    final response = await dio.get(
      '/users/info',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        }
      )
      );
      return _jsonToUser(response.data);  
  }
}