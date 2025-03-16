// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cache_answer_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnswerModelAdapter extends TypeAdapter<AnswerModel> {
  @override
  final int typeId = 0;

  @override
  AnswerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AnswerModel(
      questionId: fields[0] as String?,
      correct: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AnswerModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.questionId)
      ..writeByte(1)
      ..write(obj.correct);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnswerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CachedAnswerDataAdapter extends TypeAdapter<CachedAnswerData> {
  @override
  final int typeId = 1;

  @override
  CachedAnswerData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CachedAnswerData(
      answers: (fields[0] as List?)?.cast<AnswerModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, CachedAnswerData obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.answers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CachedAnswerDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
