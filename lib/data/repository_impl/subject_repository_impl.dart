import 'package:injectable/injectable.dart';
import 'package:online_exam_app/data/model/all_subject_dto.dart';
import 'package:online_exam_app/domain/common/result.dart';

import '../../core/api/api_execute.dart';
import '../../domain/entity/all_subject.dart';
import '../../domain/repository/subject_repository.dart';
import '../data_source/remote_data_source/subject_remote_data_source.dart';

@Injectable(as: SubjectRepository)
class SubjectRepositoryImpl implements SubjectRepository {
  SubjectRepositoryImpl(this._subject);

  final SubjectRemoteDataSource _subject;

  @override
  Future<Result<AllSubjectEntity>> getAllSubject() {
    return executeApi<AllSubjectEntity>(
      () async {
        var response = await _subject.getAllSubject();
        var data = AllSubjectDTO.fromJson(response.data);
        return data;
      },
    );
  }
}
