


import 'package:gozalapp/domain/entities/entities.dart';
import 'package:gozalapp/infraestructure/models/models.dart';

class TutorialMapper {

  static Tutorial tutorialToEntity(TutorialStatusResponse tutorial) => Tutorial(
    id: tutorial.id,
    name: tutorial.name,
    status: tutorial.status
  );
}