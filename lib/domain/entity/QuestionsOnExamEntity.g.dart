// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QuestionsOnExamEntity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionsAdapter extends TypeAdapter<Questions> {
  @override
  final int typeId = 2;

  @override
  Questions read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Questions(
      answers: (fields[0] as List?)?.cast<Answers>(),
      id: fields[1] as String?,
      question: fields[2] as String?,
      correct: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Questions obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.answers)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.question)
      ..writeByte(3)
      ..write(obj.correct);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AnswersAdapter extends TypeAdapter<Answers> {
  @override
  final int typeId = 3;

  @override
  Answers read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Answers(
      answer: fields[0] as String?,
      key: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Answers obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.answer)
      ..writeByte(1)
      ..write(obj.key);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnswersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
