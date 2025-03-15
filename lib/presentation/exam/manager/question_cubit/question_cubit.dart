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
 static Timer ? timer;
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

  void _addQuestionAnswer(AnswerModel newAnswer) async {
    final box = Hive.box<CachedAnswerData>(AppConstants.hiveBoxQuestionAnswer);

    // Retrieve existing answers
    CachedAnswerData? cachedData = box.get(AppConstants.hiveBoxAnswerKey);
    List<AnswerModel> updatedAnswers =
        List.from(cachedData?.answers ?? []); // Ensure we have a list

    // Check if the answer for this question already exists
    int existingIndex =
        updatedAnswers.indexWhere((a) => a.questionId == newAnswer.questionId);
    if (existingIndex != -1) {
      updatedAnswers[existingIndex] = newAnswer; // Update existing answer
    } else {
      updatedAnswers.add(newAnswer);
    }

    // Save the updated list back to Hive
    await box.put(AppConstants.hiveBoxAnswerKey,
        CachedAnswerData(answers: updatedAnswers));
    // Debugging output
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
        log("Error occurred: $result");
        emit(ErrorQuestionState(result.exception));
    }
  }

  void _nextQuestion(List<AnswerModel> answerModel) {
    var newAnswer = AnswerModel(
      questionId: question[currentQuestionIndex].id.toString(),
      correct: question[currentQuestionIndex].selectedAnswer.toString(),
    );
    _addQuestionAnswer(newAnswer);

    if (currentQuestionIndex < question.length - 1) {
      currentQuestionIndex++;
      emit(NextQuestionState(currentQuestionIndex));
    } else {
      emit(LastQuestionState(currentQuestionIndex)); // Now it works!
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
