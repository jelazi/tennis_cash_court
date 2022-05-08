// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tennis_hour.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TennisHour _$TennisHourFromJson(Map<String, dynamic> json) => TennisHour(
      DateTime.parse(json['date'] as String),
      (json['hours'] as num).toDouble(),
    )
      ..partners =
          (json['partners'] as List<dynamic>).map((e) => e as String).toList()
      ..id = json['id'] as String
      ..isPayd = json['isPayd'] as bool;

Map<String, dynamic> _$TennisHourToJson(TennisHour instance) =>
    <String, dynamic>{
      'hours': instance.hours,
      'date': instance.date.toIso8601String(),
      'partners': instance.partners,
      'id': instance.id,
      'isPayd': instance.isPayd,
    };
