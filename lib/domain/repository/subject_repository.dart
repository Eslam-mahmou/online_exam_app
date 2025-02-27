import 'package:online_exam_app/domain/entity/all_subject.dart';

import '../common/result.dart';

abstract class SubjectRepository {
  Future<Result<AllSubjectEntity>> getAllSubject();
}
