// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CoinDetailImpl _$$CoinDetailImplFromJson(Map<String, dynamic> json) =>
    _$CoinDetailImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      symbol: json['symbol'] as String?,
      rank: (json['rank'] as num?)?.toInt(),
      isNew: json['is_new'] as bool?,
      isActive: json['is_active'] as bool?,
      type: json['type'] as String?,
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => Tags.fromJson(e as Map<String, dynamic>))
          .toList(),
      team: (json['team'] as List<dynamic>?)
          ?.map((e) => TeamMember.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CoinDetailImplToJson(_$CoinDetailImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'symbol': instance.symbol,
      'rank': instance.rank,
      'is_new': instance.isNew,
      'is_active': instance.isActive,
      'type': instance.type,
      'tags': instance.tags,
      'team': instance.team,
    };
