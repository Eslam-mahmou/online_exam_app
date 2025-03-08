import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/utils/constant_manager.dart';
import 'package:online_exam_app/domain/common/result.dart';
import 'package:online_exam_app/domain/entity/QuestionsOnExamEntity.dart';
import 'package:online_exam_app/domain/entity/cache_answer_model.dart';
import 'package:online_exam_app/presentation/exam/manager/question_cubit/question_state.dart';

import '../../../../domain/use_case/exam_use_case.dart';

@injectable
class QuestionViewModel extends Cubit<QuestionState> {
  QuestionViewModel(this._examUseCase) : super(LoadingQuestionState());

  final ExamUseCase _examUseCase;
  List<Questions> question = [];
  int currentQuestionIndex = 0;
  void doIntent(QuestionIntent examIntent) {
    switch (examIntent) {
      case FetchQuestionIntent():
        _fetchQuestion(examIntent.examId);
      case NextQuestionIntent():
        _nextQuestion(examIntent.answerModel);
      case PreviousQuestionIntent():
        _previousQuestion();
    }
  }

  void _addQuestionAnswer(List<AnswerModel> answers) async {
    final box = Hive.box<CachedAnswerData>(AppConstants.hiveBoxQuestion);
    final answerData = CachedAnswerData(answers: answers);
    await box.put(AppConstants.hiveBoxAnswerKey, answerData);
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

  void _nextQuestion(List<AnswerModel> answerModel) {
    if (currentQuestionIndex < question.length - 1) {
      _addQuestionAnswer(
        answerModel,
      );
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

class NextQuestionIntent extends QuestionIntent {
  final List<AnswerModel> answerModel;

  NextQuestionIntent(this.answerModel);
}

class PreviousQuestionIntent extends QuestionIntent {}

