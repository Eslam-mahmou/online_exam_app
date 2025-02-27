import 'package:online_exam_app/domain/entity/all_subject.dart';

sealed class ExploreState {}

class ExploreLoading extends ExploreState {}

class ExploreSuccess extends ExploreState {
  AllSubjectEntity? subject;

  ExploreSuccess(this.subject);

  List<Object?> get props => [subject];
}

class ExploreError extends ExploreState {
  final String errMessage;

  ExploreError(this.errMessage);
}
