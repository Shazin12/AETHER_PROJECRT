// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'world_boss_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WorldBossModel _$WorldBossModelFromJson(Map<String, dynamic> json) =>
    _WorldBossModel(
      capacity: (json['capacity'] as num).toInt(),
      joinedCount: (json['joinedCount'] as num).toInt(),
      bossStartAt: _dateTimeFromTimestamp(json['bossStartAt'] as Timestamp),
    );

Map<String, dynamic> _$WorldBossModelToJson(_WorldBossModel instance) =>
    <String, dynamic>{
      'capacity': instance.capacity,
      'joinedCount': instance.joinedCount,
      'bossStartAt': _dateTimeToTimestamp(instance.bossStartAt),
    };
