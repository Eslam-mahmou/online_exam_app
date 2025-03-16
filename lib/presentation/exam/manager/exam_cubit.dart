import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/domain/common/result.dart';
import 'package:online_exam_app/domain/entity/exam_response_entity.dart';
import 'package:online_exam_app/domain/use_case/exam_use_case.dart';
import 'package:online_exam_app/presentation/exam/manager/exam_state.dart';
@injectable
class ExamViewModel extends Cubit<ExamState> {
  ExamViewModel(this._examUseCase) : super(LoadingExamState());
  final ExamUseCase _examUseCase;
  List<ExamsEntity> exams = [];
void doIntent(ExamIntent examIntent){
  switch (examIntent){
    case FetchExamIntent():
      _fetchExam(examIntent.subjectId);
  }
}
  Future<void> _fetchExam(String subjectId) async {
    emit(LoadingExamState());
    var result = await _examUseCase.invoke(subjectId);
    switch (result) {
      case Success():
        var data = result.data;
        exams = data?.exams ?? [];
        log(exams.toString());
        if(data!.message=="success") {
          emit(SuccessExamState(exams));
        }
        else{
          emit(ErrorExamState(data.message));
        }
      case Error():
        emit(ErrorExamState(result.exception));
    }
  }
}
sealed class ExamIntent {}
class FetchExamIntent extends ExamIntent {
  final String subjectId;
  FetchExamIntent(this.subjectId);
}