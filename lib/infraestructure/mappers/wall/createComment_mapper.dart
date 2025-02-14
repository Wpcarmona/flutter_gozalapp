

import 'package:gozalapp/domain/entities/entities.dart';
import 'package:gozalapp/infraestructure/models/wall/createCommen.dart';

class CreatecommentMapper {
  static CreateComment createCommentToEntity(CreateCommentResponse createComment) => CreateComment(
    ok: createComment.ok, 
    message: createComment.message
    );
}