


import 'package:gozalapp/domain/datasources/domain_datasource.dart';
import 'package:gozalapp/domain/entities/tutorial/tutorial.dart';
import 'package:gozalapp/domain/repositories/tutorial_repository/tutorial_repository.dart';

class TutorialRepositoryImpl extends TutorialRepository {

  final TutorialDatasource tutorialDatasource;

  TutorialRepositoryImpl(this.tutorialDatasource);

  @override
  Future<Tutorial> getStatusTutorial() {
    return tutorialDatasource.getStatusTutorial();
  }
  
}