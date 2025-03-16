import 'package:online_exam_app/domain/entity/all_subject.dart';

class AllSubjectDTO extends AllSubjectEntity {
  AllSubjectDTO({
    required super.message,
    required super.metadata,
    required super.subjects,
  });

  AllSubjectDTO.fromJson(dynamic json) {
    message = json['message'];
    metadata = json['metadata'] != null
        ? MetaDataDTO.fromJson(json['metadata'])
        : null;
    if (json['subjects'] != null) {
      subjects = [];
      json['subjects'].forEach((v) {
        subjects?.add(SubjectsDTO.fromJson(v));
      });
    }
  }
}

class SubjectsDTO extends SubjectsEntity {
  SubjectsDTO({super.id, super.name, super.icon});

  SubjectsDTO.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    icon = json['icon'];
  }
}

class MetaDataDTO extends Metadata {
  MetaDataDTO({super.currentPage, super.limit, super.numberOfPages});

  MetaDataDTO.fromJson(dynamic json) {
    currentPage = json['currentPage'];
    numberOfPages = json['numberOfPages'];
    limit = json['limit'];
  }
}
