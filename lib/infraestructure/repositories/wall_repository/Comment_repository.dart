


import 'package:gozalapp/domain/datasources/domain_datasource.dart';
import 'package:gozalapp/domain/entities/wall/comments.dart';
import 'package:gozalapp/domain/repositories/wall_repository/comments_repository.dart';

class CommentRepositoryImpl extends CommentsRepository {

  final CommentsDatasource commentsDatasource;
  CommentRepositoryImpl({required this.commentsDatasource});

  @override
  Future<List<GetComment>> getComments({required String targedId}) {
    return commentsDatasource.getComments(targedId: targedId);
  }
  
  @override
  Future<CreateComment> createComment({required String targedId, required String comment}) {
    // TODO: implement createComment
    throw UnimplementedError();
  }
  
}