import '../../../../domain/entity/QuestionsOnExamEntity.dart';

sealed class ResultState {}

class LoadingResultState extends ResultState {}

class ErrorResultState extends ResultState {
  final String message;
  ErrorResultState(this.message);
}

class SuccessResultState extends ResultState {
    List<Questions> questions;
    SuccessResultState(this.questions);
}
