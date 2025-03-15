
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/domain/entity/QuestionsOnExamEntity.dart';
import 'package:online_exam_app/domain/entity/check_answer_entity.dart';
import 'package:online_exam_app/domain/use_case/check_answer_use_case.dart';
import 'package:online_exam_app/presentation/exam/manager/score_cubit/score_state.dart';

import '../../../../domain/common/result.dart';

@injectable
class ScoreScreenViewModel extends Cubit<ScoreState> {
  ScoreScreenViewModel(this._checkAnswerUseCase) : super(LoadingScoreState());
  final CheckAnswerUseCase _checkAnswerUseCase ;
  CheckAnswerEntity? answerEntity;
  QuestionsOnExamEntity? questions;
  void doIntent(ScoreIntent scoreIntent) {
    switch (scoreIntent) {
      case CheckAnswerIntent():
        _checkAnswer();
    }
  }


  void _checkAnswer() async {
    emit(LoadingScoreState());
    var result = await _checkAnswerUseCase.call();
    switch (result) {
      case Success():
        var data = result.data;
       if(data!.message=="success"){
         answerEntity=data;
         emit(SuccessScoreState(data));
       }
       else{
         emit(ErrorScoreState(data.message.toString()));
       }
      case Error():
        log("result $result");
        log("Error occurred: ${result.exception}");
        emit(ErrorScoreState(result.exception.toString()));
    }
  }
}
sealed class ScoreIntent{}

class CheckAnswerIntent extends ScoreIntent{

}