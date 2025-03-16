import 'package:injectable/injectable.dart';
import 'package:online_exam_app/domain/entity/all_subject.dart';

import '../common/result.dart';
import '../repository/subject_repository.dart';

@injectable
class SubjectUseCase {
  SubjectUseCase(this._subjectRepository);

  final SubjectRepository _subjectRepository;

  Future<Result<AllSubjectEntity>> executeSubject() async {
    return await _subjectRepository.getAllSubject();
  }
}
