import 'package:online_exam_app/domain/entity/QuestionsOnExamEntity.dart';

class QuestionsOnExamDTO extends QuestionsOnExamEntity {
  QuestionsOnExamDTO({
    super.message,
    super.questions,
  });
  QuestionsOnExamDTO.fromJson(dynamic json) {
    message = json['message'];
    if (json['questions'] != null) {
      questions = [];
      json['questions'].forEach((v) {
        questions?.add(QuestionsDTO.fromJson(v));
      });
    }
  }
}

class QuestionsDTO extends Questions {
  QuestionsDTO({
    super.answers,
    super.type,
    super.id,
    super.question,
    super.correct,
    super.subject,
    super.exam,
    super.createdAt,
  });

  QuestionsDTO.fromJson(dynamic json) {
    if (json['answers'] != null) {
      answers = [] ;
      json['answers'].forEach((v) {
        answers?.add(Answers.fromJson(v));
      });
    }
    type = json['type'];
    id = json['_id'];
    question = json['question'];
    correct = json['correct'];
    subject =
        json['subject'] != null ? Subject.fromJson(json['subject']) : null;
    exam = json['exam'] != null ? ExamDTO.fromJson(json['exam']) : null;
    createdAt = json['createdAt'];
  }
}

class ExamDTO extends Exam {
  ExamDTO({
    super.id,
    super.title,
    super.duration,
    super.subject,
    super.numberOfQuestions,
    super.active,
    super.createdAt,
  });

  ExamDTO.fromJson(dynamic json) {
    id = json['_id'];
    title = json['title'];
    duration = json['duration'];
    subject = json['subject'];
    numberOfQuestions = json['numberOfQuestions'];
    active = json['active'];
    createdAt = json['createdAt'];
  }
}

class SubjectDTO extends Subject {
  SubjectDTO({
    super.id,
    super.name,
    super.icon,
    super.createdAt,
  });

  SubjectDTO.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    icon = json['icon'];
    createdAt = json['createdAt'];
  }
}

class AnswersDTO extends Answers {
  AnswersDTO({
    super.answer,
    super.key,
  });

  AnswersDTO.fromJson(dynamic json) {
    answer = json['answer'];
    key = json['key'];
  }
}
