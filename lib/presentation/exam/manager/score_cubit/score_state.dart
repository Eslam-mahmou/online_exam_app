import '../../../../domain/entity/check_answer_entity.dart';
sealed class ScoreState {}
final class   LoadingScoreState extends ScoreState {}

final class SuccessScoreState extends ScoreState {
  final CheckAnswerEntity scores;
  SuccessScoreState(this.scores);
}

final class ErrorScoreState extends ScoreState {
  final String errMessage;
  ErrorScoreState(this.errMessage);
}
