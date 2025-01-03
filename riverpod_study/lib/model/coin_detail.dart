import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_study/model/tags.dart';
import 'package:riverpod_study/model/team_member.dart';

part 'coin_detail.freezed.dart';
part 'coin_detail.g.dart';

@freezed
class CoinDetail with _$CoinDetail {
  factory CoinDetail({
    String? id,
    String? name,
    String? symbol,
    int? rank,
    bool? isNew,
    bool? isActive,
    String? type,
    List<Tags>? tags,
    List<TeamMember>? team,
  }) = _CoinDetail;

  factory CoinDetail.fromJson(Map<String, dynamic> json) =>
      _$CoinDetailFromJson(json);
}
