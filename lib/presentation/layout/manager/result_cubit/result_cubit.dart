import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/domain/use_case/result_use_case.dart';
import 'package:online_exam_app/presentation/layout/manager/result_cubit/result_state.dart';

import '../../../../core/utils/constant_manager.dart';
import '../../../../domain/entity/QuestionsOnExamEntity.dart';
import '../../../../domain/entity/cache_answer_model.dart';

@injectable
class ResultViewModel extends Cubit<ResultState> {
  final ResultUseCase _resultUseCase;

  ResultViewModel(this._resultUseCase) : super(LoadingResultState());
  Future<void> fetchResult() async {
    emit(LoadingResultState());
    try {
      final List<Questions> result = await _resultUseCase.getResult();

      final box =
          Hive.box<CachedAnswerData>(AppConstants.hiveBoxQuestionAnswer);
      CachedAnswerData? cachedData = box.get(AppConstants.hiveBoxAnswerKey);
      debugPrint("cachedData");
      cachedData?.answers?.forEach((a) {
      });
      List<AnswerModel> updatedAnswers = cachedData?.answers ?? [];

      // Iterate over fetched questions and update with selected answer
      final updatedQuestions = result.map((question) {
        // Find the user's selected answer for this question
        var userAnswer = updatedAnswers.firstWhere(
          (answer) => answer.questionId == question.id,
          orElse: () => AnswerModel(questionId: question.id, correct: null),
        );

        return question.copyWith(selectedAnswer: userAnswer.correct);
      }).toList();

      emit(SuccessResultState(updatedQuestions));
    } catch (e) {
      emit(ErrorResultState(e.toString()));
    }
  }
}
