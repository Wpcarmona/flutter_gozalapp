
import 'package:gozalapp/config/constants/environment.dart';
import 'package:gozalapp/domain/datasources/domain_datasource.dart';
import 'package:gozalapp/domain/entities/wall/comments.dart';
import 'package:dio/dio.dart';
import 'package:gozalapp/infraestructure/mappers/wall/createComment_mapper.dart';
import 'package:gozalapp/infraestructure/mappers/wall/getComments_mapper.dart';
import 'package:gozalapp/infraestructure/models/models.dart';
import 'package:gozalapp/infraestructure/models/wall/createCommen.dart';

class CommentSPDatasource extends CommentsDatasource{

 final dio = Dio(BaseOptions(
    baseUrl: Environment.baseUrl,
    headers: {
      'Authorization': 'Bearer 123', //TODO agregar el header desde el isar
    }
  ));

  List<GetComment> _jsonToGetComments(Map<String, dynamic> json){
    final commentsResponse = GetCommentResponse.fromJson(json);
    return GetCommentsMapper.getCommentsToEntity(commentsResponse);
  }

  CreateComment _jsonToCreateComment(Map<String, dynamic> json){
    final createCommentResponse = CreateCommentResponse.fromJson(json);
    return CreatecommentMapper.createCommentToEntity(createCommentResponse);
  }

  @override
  Future<List<GetComment>> getComments({required String targedId}) async {
    final response = await dio.get(
      '/wall/comments',
      options: Options(
        headers: {
          'Authorization': 'Bearer 123', //TODO agregar el header desde el isar
        }
      ),
      queryParameters: {
        'target_id': targedId
      }
    );
    return _jsonToGetComments(response.data);
  }
  
  @override
  Future<CreateComment> createComment({
    required String targedId, 
    required String comment}) async {
    final response = await dio.post(
      '/wall/comments',
      options: Options(
        headers: {
          'Authorization': 'Bearer 123', //TODO agregar el header desde el isar
        }
      ),
      data: {
        'target_id': targedId,
        'body': comment
      }
    );
    return _jsonToCreateComment(response.data);
  }
  
}