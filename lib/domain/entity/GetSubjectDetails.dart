
class GetSubjectDetails {
  GetSubjectDetails({
    this.message,
    this.metadata,
    this.exams,
  });

  GetSubjectDetails.fromJson(dynamic json) {
    message = json['message'];
    metadata =
        json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
    if (json['exams'] != null) {
      exams = [];
      json['exams'].forEach((v) {
        exams?.add(Exams.fromJson(v));
      });
    }
  }

  String? message;
  Metadata? metadata;
  List<Exams>? exams;

// GetSubjectDetails copyWith({  String? message,
//   Metadata? metadata,
//   List<Exams>? exams,
// }) => GetSubjectDetails(  message: message ?? this.message,
//   metadata: metadata ?? this.metadata,
//   exams: exams ?? this.exams,
// );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (metadata != null) {
      map['metadata'] = metadata?.toJson();
    }
    if (exams != null) {
      map['exams'] = exams?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// _id : "670070a830a3c3c1944a9c63"
/// title : "HTML Quiz"
/// duration : 25
/// subject : "670037f6728c92b7fdf434fc"
/// numberOfQuestions : 40
/// active : true
/// createdAt : "2024-10-04T22:48:08.842Z"

class Exams {
  Exams({
    this.id,
    this.title,
    this.duration,
    this.subject,
    this.numberOfQuestions,
    this.active,
    this.createdAt,
  });

  Exams.fromJson(dynamic json) {
    id = json['_id'];
    title = json['title'];
    duration = json['duration'];
    subject = json['subject'];
    numberOfQuestions = json['numberOfQuestions'];
    active = json['active'];
    createdAt = json['createdAt'];
  }

  String? id;
  String? title;
  int? duration;
  String? subject;
  int? numberOfQuestions;
  bool? active;
  String? createdAt;

// Exams copyWith({  String? id,
//   String? title,
//   int? duration,
//   String? subject,
//   int? numberOfQuestions,
//   bool? active,
//   String? createdAt,
// }) => Exams(  id: id ?? this.id,
//   title: title ?? this.title,
//   duration: duration ?? this.duration,
//   subject: subject ?? this.subject,
//   numberOfQuestions: numberOfQuestions ?? this.numberOfQuestions,
//   active: active ?? this.active,
//   createdAt: createdAt ?? this.createdAt,
// );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['title'] = title;
    map['duration'] = duration;
    map['subject'] = subject;
    map['numberOfQuestions'] = numberOfQuestions;
    map['active'] = active;
    map['createdAt'] = createdAt;
    return map;
  }
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

  Metadata.fromJson(dynamic json) {
    currentPage = json['currentPage'];
    numberOfPages = json['numberOfPages'];
    limit = json['limit'];
  }

  int? currentPage;
  int? numberOfPages;
  int? limit;

// Metadata copyWith({  int? currentPage,
//   int? numberOfPages,
//   int? limit,
// }) => Metadata(  currentPage: currentPage ?? this.currentPage,
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
