

import 'package:gozalapp/domain/entities/entities.dart';

abstract class TutorialRepository {
  Future<Tutorial> getStatusTutorial();
}