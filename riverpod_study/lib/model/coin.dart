import 'package:freezed_annotation/freezed_annotation.dart';

part 'coin.freezed.dart';
part 'coin.g.dart';

List<Coin> coinFromJson(dynamic str) => List<Coin>.from(
      (str).map(
        (e) => Coin.fromJson(e),
      ),
    );

@freezed
class Coin with _$Coin {
  factory Coin({
    String? id,
    String? name,
    String? symbol,
    int? rank,
    bool? isNew,
    bool? isActive,
    String? type,
  }) = _Coin;

  factory Coin.fromJson(Map<String, dynamic> json) => _$CoinFromJson(json);
}
