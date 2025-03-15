import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/domain/common/result.dart';
import 'package:online_exam_app/domain/entity/all_subject.dart';
import 'package:online_exam_app/domain/use_case/subject_use_case.dart';
import 'package:online_exam_app/presentation/layout/manager/explore_cubit/explore_state.dart';

@injectable
class ExploreViewModel extends Cubit<ExploreState> {
  ExploreViewModel(this._subjectUseCase) : super(ExploreLoading());

  final SubjectUseCase _subjectUseCase;
  AllSubjectEntity? subject;

  void doIntent(ExploreIntent subjectIntent) {
    switch (subjectIntent) {
      case GetAllSubjectIntent():
        _fetchSubject();
    }
  }
  Future<void> _fetchSubject() async {
    emit(ExploreLoading());
    var result = await _subjectUseCase.executeSubject();

    switch (result) {
      case Success():
        var data = result.data;
        if (data != null && data.subjects!.isNotEmpty) {
          log("Fetched subjects: ${data.subjects}");
          subject = data;
          emit(ExploreSuccess(subject!));
        } else {
          emit(ExploreError("No subjects found."));
        }
      case Error():
        emit(ExploreError(result.exception?.toString() ?? "API Error"));
    }
  }
}

sealed class ExploreIntent {}

class GetAllSubjectIntent extends ExploreIntent {}
