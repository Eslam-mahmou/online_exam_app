// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solve_questions_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SolveQuestionsModelAdapter extends TypeAdapter<SolveQuestionsModel> {
  @override
  final int typeId = 0;

  @override
  SolveQuestionsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SolveQuestionsModel(
      fields[0] as String?,
      fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SolveQuestionsModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.questionId)
      ..writeByte(1)
      ..write(obj.selectAnswer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SolveQuestionsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
