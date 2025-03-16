import 'package:equatable/equatable.dart';

class AllSubjectEntity {
  AllSubjectEntity({
    this.message,
    this.metadata,
    this.subjects,
  });

  String? message;
  Metadata? metadata;
  List<SubjectsEntity>? subjects;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (metadata != null) {
      map['metadata'] = metadata?.toJson();
    }
    if (subjects != null) {
      map['subjects'] = subjects?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class SubjectsEntity extends Equatable {
  SubjectsEntity({
    this.id,
    this.name,
    this.icon,
  });

  String? id;
  String? name;
  String? icon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['icon'] = icon;
    return map;
  }

  @override
  List<Object?> get props => [id, name, icon];
}

class Metadata {
  Metadata({
    this.currentPage,
    this.numberOfPages,
    this.limit,
  });

  int? currentPage;
  int? numberOfPages;
  int? limit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['currentPage'] = currentPage;
    map['numberOfPages'] = numberOfPages;
    map['limit'] = limit;
    return map;
  }
}
