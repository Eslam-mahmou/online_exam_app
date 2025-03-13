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
      type: fields[1] as String?,
      id: fields[2] as String?,
      question: fields[3] as String?,
      correct: fields[4] as String?,
      subject: fields[5] as Subject?,
      exam: fields[6] as Exam?,
      createdAt: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Questions obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.answers)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.question)
      ..writeByte(4)
      ..write(obj.correct)
      ..writeByte(5)
      ..write(obj.subject)
      ..writeByte(6)
      ..write(obj.exam)
      ..writeByte(7)
      ..write(obj.createdAt);
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
