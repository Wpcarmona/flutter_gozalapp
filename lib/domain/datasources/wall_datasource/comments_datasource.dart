


import 'package:gozalapp/domain/entities/entities.dart';

abstract class CommentsDatasource {
  Future<List<GetComment>> getComments({required String targedId});

  Future<CreateComment> createComment({
    required String targedId,
    required String comment,
  });
}