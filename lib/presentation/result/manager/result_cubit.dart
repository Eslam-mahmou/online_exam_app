import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/domain/entity/QuestionsOnExamEntity.dart';
import 'package:online_exam_app/domain/use_case/result_use_case.dart';
import 'package:online_exam_app/presentation/result/manager/result_state.dart';

@injectable
class ResultViewModel extends Cubit<ResultState> {
  ResultViewModel(this._resultUseCase) : super(LoadingResultState());
 final ResultUseCase _resultUseCase;
List<Questions> questionsList = [];
  Future<void> fetchResult() async {
    emit(LoadingResultState());
    try {
      var result = await _resultUseCase.getResult();
      questionsList = result;
      emit(SuccessResultState(result));
    } catch (e) {
      emit(ErrorResultState(e.toString()));
    }

  }
}
