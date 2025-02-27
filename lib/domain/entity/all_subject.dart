import 'package:equatable/equatable.dart';

/// message : "success"
/// metadata : {"currentPage":1,"numberOfPages":1,"limit":40}
/// subjects : [{"_id":"670037f6728c92b7fdf434fc","name":"HTML","icon":"https://exam.elevateegy.com/uploads/categories/6751d734cc3deba60dd5bc80-item_1.png","createdAt":"2024-10-04T18:46:14.281Z"},{"_id":"670038f7728c92b7fdf43501","name":"CSS","icon":"https://exam.elevateegy.com/uploads/categories/6751d73fcc3deba60dd5bc84-item_2.png","createdAt":"2024-10-04T18:50:31.606Z"},{"_id":"670039c3728c92b7fdf43506","name":"Javascript","icon":"https://exam.elevateegy.com/uploads/categories/6751d74ccc3deba60dd5bc88-item_3.png","createdAt":"2024-10-04T18:53:55.992Z"},{"_id":"67003a9a728c92b7fdf4350a","name":"Angular","icon":"https://exam.elevateegy.com/uploads/categories/6751d758cc3deba60dd5bc8c-item_4.png","createdAt":"2024-10-04T18:57:30.499Z"}]

class AllSubjectEntity {
  AllSubjectEntity({
    this.message,
    this.metadata,
    this.subjects,
  });

  String? message;
  Metadata? metadata;
  List<SubjectsEntity>? subjects;

//
// AllSubjectEntity copyWith({  String? message,
//   Metadata? metadata,
//   List<SubjectsEntity>? subjects,
// }) =>
//     AllSubjectEntity(  message: message ?? this.message,
//   metadata: metadata ?? this.metadata,
//   subjects: subjects ?? this.subjects,
// );

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

/// _id : "670037f6728c92b7fdf434fc"
/// name : "HTML"
/// icon : "https://exam.elevateegy.com/uploads/categories/6751d734cc3deba60dd5bc80-item_1.png"
/// createdAt : "2024-10-04T18:46:14.281Z"

class SubjectsEntity extends Equatable {
  SubjectsEntity({
    this.id,
    this.name,
    this.icon,
  });

  String? id;
  String? name;
  String? icon;

// SubjectsEntity copyWith({  String? id,
//   String? name,
//   String? icon,
//   String? createdAt,
// }) =>
//     SubjectsEntity(
//   id: id ?? this.id,
//   name: name ?? this.name,
//   icon: icon ?? this.icon,
// );
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

/// currentPage : 1
/// numberOfPages : 1
/// limit : 40

class Metadata {
  Metadata({
    this.currentPage,
    this.numberOfPages,
    this.limit,
  });

  int? currentPage;
  int? numberOfPages;
  int? limit;

// Metadata copyWith({  int? currentPage,
//   int? numberOfPages,
//   int? limit,
// }) =>
//     Metadata(  currentPage: currentPage ?? this.currentPage,
//   numberOfPages: numberOfPages ?? this.numberOfPages,
//   limit: limit ?? this.limit,
// );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['currentPage'] = currentPage;
    map['numberOfPages'] = numberOfPages;
    map['limit'] = limit;
    return map;
  }
}
