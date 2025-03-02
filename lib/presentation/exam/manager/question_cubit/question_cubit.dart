import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/domain/common/result.dart';
import 'package:online_exam_app/domain/entity/QuestionsOnExamEntity.dart';
import 'package:online_exam_app/presentation/exam/manager/question_cubit/question_state.dart';

import '../../../../domain/use_case/exam_use_case.dart';

@injectable
class QuestionViewModel extends Cubit<QuestionState> {
  QuestionViewModel(this._examUseCase) : super(LoadingQuestionState());
  final ExamUseCase _examUseCase;
  List<Questions> question = [];

  void doIntent(QuestionIntent examIntent) {
    switch (examIntent) {
      case FetchQuestionIntent():
        _fetchQuestion(examIntent.examId);
    }
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
}

sealed class QuestionIntent {}

class FetchQuestionIntent extends QuestionIntent {
  final String examId;

  FetchQuestionIntent(this.examId);
}
