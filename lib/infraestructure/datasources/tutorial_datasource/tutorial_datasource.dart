
import 'package:gozalapp/config/constants/environment.dart';
import 'package:gozalapp/domain/datasources/domain_datasource.dart';
import 'package:gozalapp/domain/entities/tutorial/tutorial.dart';
import 'package:dio/dio.dart';
import 'package:gozalapp/infraestructure/mappers/tutorial/tutorial_mapper.dart';
import 'package:gozalapp/infraestructure/models/models.dart';

class TutorialSPDatasource extends TutorialDatasource {
 final dio = Dio(BaseOptions(
    baseUrl: Environment.baseUrl,
  ));

  Tutorial _jsonToTutorial(Map<String, dynamic> json){
    final tutorialResponse = TutorialStatusResponse.fromJson(json);
    return TutorialMapper.tutorialToEntity(tutorialResponse);
  }
  @override
  Future<Tutorial> getStatusTutorial() async {
    final response = await dio.get(
      '/tutorial/status',
      options: Options(
        headers: {
          'Authorization': 'Bearer 123', //TODO agregar el header desde el isar
          'Content-Type': 'application/json'
        }
      )
    );

    return _jsonToTutorial(response.data);
  }
  
}