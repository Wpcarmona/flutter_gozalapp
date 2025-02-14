


import 'package:gozalapp/domain/entities/entities.dart';
import 'package:gozalapp/infraestructure/models/models.dart';

class GetCommentsMapper {
  static List<GetComment> getCommentsToEntity(GetCommentResponse response) {
    return response.comments.map((comment) => GetComment(
      id: comment.id,
      text: comment.body,
      nameUser: comment.name,
      imageUser: comment.avatar,
      date: comment.executeDate.toIso8601String(), // Convertimos DateTime a String
    )).toList();
  }
}