import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/domain/use_case/result_use_case.dart';
import 'package:online_exam_app/presentation/result/manager/result_state.dart';

@injectable
@injectable
class ResultViewModel extends Cubit<ResultState> {
  final ResultUseCase _resultUseCase;

  ResultViewModel(this._resultUseCase) : super(LoadingResultState());

  Future<void> fetchResult() async {
    emit(LoadingResultState());
    try {
      final result = await _resultUseCase.getResult();
      emit(SuccessResultState(result));
    } catch (e) {
      emit(ErrorResultState(e.toString()));
    }
  }
}
