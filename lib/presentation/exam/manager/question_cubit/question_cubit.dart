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

  // void _addQuestionAnswer(List<AnswerModel> answers) async {
  //   final box = Hive.box<CachedAnswerData>(AppConstants.hiveBoxQuestion);
  //   final answerData = CachedAnswerData(answers: answers);
  //   await box.put(AppConstants.hiveBoxAnswerKey, answerData);
  // }
  void _addQuestionAnswer(AnswerModel newAnswer) async {
    final box = Hive.box<CachedAnswerData>(AppConstants.hiveBoxQuestionAnswer);

    // Retrieve existing answers
    CachedAnswerData? cachedData = box.get(AppConstants.hiveBoxAnswerKey);
    List<AnswerModel> updatedAnswers = cachedData?.answers ?? [];

    // Check if an answer for the same question already exists
    int existingIndex =
        updatedAnswers.indexWhere((a) => a.questionId == newAnswer.questionId);

    if (existingIndex != -1) {
      // Update the existing answer
      updatedAnswers[existingIndex] = newAnswer;
    } else {
      updatedAnswers.add(newAnswer);
    }
    await box.put(AppConstants.hiveBoxAnswerKey,
        CachedAnswerData(answers: updatedAnswers));
    print(
        '✅ Updated Answer List: ${updatedAnswers.map((e) => e.toJson()).toList()}');
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
        log("Error occurred: ${result.exception}");
        emit(ErrorQuestionState(result.exception));
    }
  }

  void _nextQuestion(List<AnswerModel> answerModel) {
    if (currentQuestionIndex < question.length - 1) {
      // Ensure the answer model is created properly
      var newAnswer = AnswerModel(
        questionId: question[currentQuestionIndex].id.toString(),
        correct: question[currentQuestionIndex].selectedAnswer.toString(),
      );

      // Use `_addQuestionAnswer()` to store the answer in Hive
      _addQuestionAnswer(newAnswer);

      // Move to the next question
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

