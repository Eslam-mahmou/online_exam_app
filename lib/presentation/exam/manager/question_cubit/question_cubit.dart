import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/utils/constant_manager.dart';
import 'package:online_exam_app/domain/common/result.dart';
import 'package:online_exam_app/domain/entity/QuestionsOnExamEntity.dart';
import 'package:online_exam_app/domain/entity/solve_questions_model.dart';
import 'package:online_exam_app/presentation/exam/manager/question_cubit/question_state.dart';

import '../../../../domain/use_case/exam_use_case.dart';

@injectable
class QuestionViewModel extends Cubit<QuestionState> {
  QuestionViewModel(this._examUseCase) : super(LoadingQuestionState());

  final ExamUseCase _examUseCase;
  List<Questions> question = [];
  int currentQuestionIndex = 0;
  static String selectedAnswer = "";

  void doIntent(QuestionIntent examIntent) {
    switch (examIntent) {
      case FetchQuestionIntent():
        _fetchQuestion(examIntent.examId);
      case NextQuestionIntent():
        _nextQuestion();
      case PreviousQuestionIntent():
        _previousQuestion();
      case AddQuestionAnswerIntent():
        _addQuestionAnswer(examIntent.answerModel);
    }
  }

  void _addQuestionAnswer(SolveQuestionsModel answerModel) async {
    var box = Hive.box<SolveQuestionsModel>(AppConstants.hiveBoxQuestion);
    await box.add(answerModel);
    log(answerModel.selectAnswer.toString());
  }

  Future<void> _fetchQuestion(String examId) async {
    emit(LoadingQuestionState());
    var result = await _examUseCase.callQuestionOnExam(examId);
    switch (result) {
      case Success():
        var data = result.data;
        question = data?.questions ?? [];
        log(question.toString());
        if (data!.message == "success") {
          emit(SuccessQuestionState(question));
        } else {
          emit(ErrorQuestionState(data.message));
        }
      case Error():
        emit(ErrorQuestionState(result.exception));
    }
  }

  void _nextQuestion() {
    if (currentQuestionIndex < question.length - 1) {
      _addQuestionAnswer(SolveQuestionsModel(
          question[currentQuestionIndex].id, selectedAnswer));
      currentQuestionIndex++;
      emit(NextQuestionState(currentQuestionIndex));
    }
  }

  void _previousQuestion() {
    if (currentQuestionIndex > 0) {
      currentQuestionIndex--;
      emit(PreviousQuestionState(currentQuestionIndex));
    }
  }
}

sealed class QuestionIntent {}

class FetchQuestionIntent extends QuestionIntent {
  final String examId;

  FetchQuestionIntent(this.examId);
}

class NextQuestionIntent extends QuestionIntent {}

class PreviousQuestionIntent extends QuestionIntent {}

class AddQuestionAnswerIntent extends QuestionIntent {
  final SolveQuestionsModel answerModel;

  AddQuestionAnswerIntent(this.answerModel);
}
