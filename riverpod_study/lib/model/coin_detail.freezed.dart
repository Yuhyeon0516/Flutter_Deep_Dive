// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'coin_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CoinDetail _$CoinDetailFromJson(Map<String, dynamic> json) {
  return _CoinDetail.fromJson(json);
}

/// @nodoc
mixin _$CoinDetail {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get symbol => throw _privateConstructorUsedError;
  int? get rank => throw _privateConstructorUsedError;
  bool? get isNew => throw _privateConstructorUsedError;
  bool? get isActive => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  List<Tags>? get tags => throw _privateConstructorUsedError;
  List<TeamMember>? get team => throw _privateConstructorUsedError;

  /// Serializes this CoinDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CoinDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CoinDetailCopyWith<CoinDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoinDetailCopyWith<$Res> {
  factory $CoinDetailCopyWith(
          CoinDetail value, $Res Function(CoinDetail) then) =
      _$CoinDetailCopyWithImpl<$Res, CoinDetail>;
  @useResult
  $Res call(
      {String? id,
      String? name,
      String? symbol,
      int? rank,
      bool? isNew,
      bool? isActive,
      String? type,
      List<Tags>? tags,
      List<TeamMember>? team});
}

/// @nodoc
class _$CoinDetailCopyWithImpl<$Res, $Val extends CoinDetail>
    implements $CoinDetailCopyWith<$Res> {
  _$CoinDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CoinDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? symbol = freezed,
    Object? rank = freezed,
    Object? isNew = freezed,
    Object? isActive = freezed,
    Object? type = freezed,
    Object? tags = freezed,
    Object? team = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      symbol: freezed == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String?,
      rank: freezed == rank
          ? _value.rank
          : rank // ignore: cast_nullable_to_non_nullable
              as int?,
      isNew: freezed == isNew
          ? _value.isNew
          : isNew // ignore: cast_nullable_to_non_nullable
              as bool?,
      isActive: freezed == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<Tags>?,
      team: freezed == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as List<TeamMember>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CoinDetailImplCopyWith<$Res>
    implements $CoinDetailCopyWith<$Res> {
  factory _$$CoinDetailImplCopyWith(
          _$CoinDetailImpl value, $Res Function(_$CoinDetailImpl) then) =
      __$$CoinDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? name,
      String? symbol,
      int? rank,
      bool? isNew,
      bool? isActive,
      String? type,
      List<Tags>? tags,
      List<TeamMember>? team});
}

/// @nodoc
class __$$CoinDetailImplCopyWithImpl<$Res>
    extends _$CoinDetailCopyWithImpl<$Res, _$CoinDetailImpl>
    implements _$$CoinDetailImplCopyWith<$Res> {
  __$$CoinDetailImplCopyWithImpl(
      _$CoinDetailImpl _value, $Res Function(_$CoinDetailImpl) _then)
      : super(_value, _then);

  /// Create a copy of CoinDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? symbol = freezed,
    Object? rank = freezed,
    Object? isNew = freezed,
    Object? isActive = freezed,
    Object? type = freezed,
    Object? tags = freezed,
    Object? team = freezed,
  }) {
    return _then(_$CoinDetailImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      symbol: freezed == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String?,
      rank: freezed == rank
          ? _value.rank
          : rank // ignore: cast_nullable_to_non_nullable
              as int?,
      isNew: freezed == isNew
          ? _value.isNew
          : isNew // ignore: cast_nullable_to_non_nullable
              as bool?,
      isActive: freezed == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<Tags>?,
      team: freezed == team
          ? _value._team
          : team // ignore: cast_nullable_to_non_nullable
              as List<TeamMember>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CoinDetailImpl implements _CoinDetail {
  _$CoinDetailImpl(
      {this.id,
      this.name,
      this.symbol,
      this.rank,
      this.isNew,
      this.isActive,
      this.type,
      final List<Tags>? tags,
      final List<TeamMember>? team})
      : _tags = tags,
        _team = team;

  factory _$CoinDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$CoinDetailImplFromJson(json);

  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? symbol;
  @override
  final int? rank;
  @override
  final bool? isNew;
  @override
  final bool? isActive;
  @override
  final String? type;
  final List<Tags>? _tags;
  @override
  List<Tags>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<TeamMember>? _team;
  @override
  List<TeamMember>? get team {
    final value = _team;
    if (value == null) return null;
    if (_team is EqualUnmodifiableListView) return _team;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'CoinDetail(id: $id, name: $name, symbol: $symbol, rank: $rank, isNew: $isNew, isActive: $isActive, type: $type, tags: $tags, team: $team)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CoinDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.rank, rank) || other.rank == rank) &&
            (identical(other.isNew, isNew) || other.isNew == isNew) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality().equals(other._team, _team));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      symbol,
      rank,
      isNew,
      isActive,
      type,
      const DeepCollectionEquality().hash(_tags),
      const DeepCollectionEquality().hash(_team));

  /// Create a copy of CoinDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CoinDetailImplCopyWith<_$CoinDetailImpl> get copyWith =>
      __$$CoinDetailImplCopyWithImpl<_$CoinDetailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CoinDetailImplToJson(
      this,
    );
  }
}

abstract class _CoinDetail implements CoinDetail {
  factory _CoinDetail(
      {final String? id,
      final String? name,
      final String? symbol,
      final int? rank,
      final bool? isNew,
      final bool? isActive,
      final String? type,
      final List<Tags>? tags,
      final List<TeamMember>? team}) = _$CoinDetailImpl;

  factory _CoinDetail.fromJson(Map<String, dynamic> json) =
      _$CoinDetailImpl.fromJson;

  @override
  String? get id;
  @override
  String? get name;
  @override
  String? get symbol;
  @override
  int? get rank;
  @override
  bool? get isNew;
  @override
  bool? get isActive;
  @override
  String? get type;
  @override
  List<Tags>? get tags;
  @override
  List<TeamMember>? get team;

  /// Create a copy of CoinDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CoinDetailImplCopyWith<_$CoinDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
