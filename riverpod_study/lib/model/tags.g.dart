// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tags.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TagsImpl _$$TagsImplFromJson(Map<String, dynamic> json) => _$TagsImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      coinCounter: (json['coin_counter'] as num?)?.toInt(),
      icoCounter: (json['ico_counter'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$TagsImplToJson(_$TagsImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'coin_counter': instance.coinCounter,
      'ico_counter': instance.icoCounter,
    };
