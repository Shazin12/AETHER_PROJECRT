import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'world_boss_model.freezed.dart';
part 'world_boss_model.g.dart';

@freezed
abstract class WorldBossModel with _$WorldBossModel {
  const factory WorldBossModel({
    required int capacity,
    required int joinedCount,
    @JsonKey(
      fromJson: _dateTimeFromTimestamp,
      includeFromJson: true,
      toJson: _dateTimeToTimestamp,
      includeToJson: true,
    )
    required DateTime bossStartAt,
  }) = _WorldBossModel;

  factory WorldBossModel.fromJson(Map<String, dynamic> json) =>
      _$WorldBossModelFromJson(json);
}

DateTime _dateTimeFromTimestamp(Timestamp timestamp) => timestamp.toDate();

Timestamp _dateTimeToTimestamp(DateTime dateTime) =>
    Timestamp.fromDate(dateTime);
