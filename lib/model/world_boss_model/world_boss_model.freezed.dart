// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'world_boss_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WorldBossModel {

 int get capacity; int get joinedCount;@JsonKey(fromJson: _dateTimeFromTimestamp, includeFromJson: true, toJson: _dateTimeToTimestamp, includeToJson: true) DateTime get bossStartAt;
/// Create a copy of WorldBossModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorldBossModelCopyWith<WorldBossModel> get copyWith => _$WorldBossModelCopyWithImpl<WorldBossModel>(this as WorldBossModel, _$identity);

  /// Serializes this WorldBossModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorldBossModel&&(identical(other.capacity, capacity) || other.capacity == capacity)&&(identical(other.joinedCount, joinedCount) || other.joinedCount == joinedCount)&&(identical(other.bossStartAt, bossStartAt) || other.bossStartAt == bossStartAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,capacity,joinedCount,bossStartAt);

@override
String toString() {
  return 'WorldBossModel(capacity: $capacity, joinedCount: $joinedCount, bossStartAt: $bossStartAt)';
}


}

/// @nodoc
abstract mixin class $WorldBossModelCopyWith<$Res>  {
  factory $WorldBossModelCopyWith(WorldBossModel value, $Res Function(WorldBossModel) _then) = _$WorldBossModelCopyWithImpl;
@useResult
$Res call({
 int capacity, int joinedCount,@JsonKey(fromJson: _dateTimeFromTimestamp, includeFromJson: true, toJson: _dateTimeToTimestamp, includeToJson: true) DateTime bossStartAt
});




}
/// @nodoc
class _$WorldBossModelCopyWithImpl<$Res>
    implements $WorldBossModelCopyWith<$Res> {
  _$WorldBossModelCopyWithImpl(this._self, this._then);

  final WorldBossModel _self;
  final $Res Function(WorldBossModel) _then;

/// Create a copy of WorldBossModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? capacity = null,Object? joinedCount = null,Object? bossStartAt = null,}) {
  return _then(_self.copyWith(
capacity: null == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int,joinedCount: null == joinedCount ? _self.joinedCount : joinedCount // ignore: cast_nullable_to_non_nullable
as int,bossStartAt: null == bossStartAt ? _self.bossStartAt : bossStartAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [WorldBossModel].
extension WorldBossModelPatterns on WorldBossModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorldBossModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorldBossModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorldBossModel value)  $default,){
final _that = this;
switch (_that) {
case _WorldBossModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorldBossModel value)?  $default,){
final _that = this;
switch (_that) {
case _WorldBossModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int capacity,  int joinedCount, @JsonKey(fromJson: _dateTimeFromTimestamp, includeFromJson: true, toJson: _dateTimeToTimestamp, includeToJson: true)  DateTime bossStartAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorldBossModel() when $default != null:
return $default(_that.capacity,_that.joinedCount,_that.bossStartAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int capacity,  int joinedCount, @JsonKey(fromJson: _dateTimeFromTimestamp, includeFromJson: true, toJson: _dateTimeToTimestamp, includeToJson: true)  DateTime bossStartAt)  $default,) {final _that = this;
switch (_that) {
case _WorldBossModel():
return $default(_that.capacity,_that.joinedCount,_that.bossStartAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int capacity,  int joinedCount, @JsonKey(fromJson: _dateTimeFromTimestamp, includeFromJson: true, toJson: _dateTimeToTimestamp, includeToJson: true)  DateTime bossStartAt)?  $default,) {final _that = this;
switch (_that) {
case _WorldBossModel() when $default != null:
return $default(_that.capacity,_that.joinedCount,_that.bossStartAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WorldBossModel implements WorldBossModel {
  const _WorldBossModel({required this.capacity, required this.joinedCount, @JsonKey(fromJson: _dateTimeFromTimestamp, includeFromJson: true, toJson: _dateTimeToTimestamp, includeToJson: true) required this.bossStartAt});
  factory _WorldBossModel.fromJson(Map<String, dynamic> json) => _$WorldBossModelFromJson(json);

@override final  int capacity;
@override final  int joinedCount;
@override@JsonKey(fromJson: _dateTimeFromTimestamp, includeFromJson: true, toJson: _dateTimeToTimestamp, includeToJson: true) final  DateTime bossStartAt;

/// Create a copy of WorldBossModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorldBossModelCopyWith<_WorldBossModel> get copyWith => __$WorldBossModelCopyWithImpl<_WorldBossModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WorldBossModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorldBossModel&&(identical(other.capacity, capacity) || other.capacity == capacity)&&(identical(other.joinedCount, joinedCount) || other.joinedCount == joinedCount)&&(identical(other.bossStartAt, bossStartAt) || other.bossStartAt == bossStartAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,capacity,joinedCount,bossStartAt);

@override
String toString() {
  return 'WorldBossModel(capacity: $capacity, joinedCount: $joinedCount, bossStartAt: $bossStartAt)';
}


}

/// @nodoc
abstract mixin class _$WorldBossModelCopyWith<$Res> implements $WorldBossModelCopyWith<$Res> {
  factory _$WorldBossModelCopyWith(_WorldBossModel value, $Res Function(_WorldBossModel) _then) = __$WorldBossModelCopyWithImpl;
@override @useResult
$Res call({
 int capacity, int joinedCount,@JsonKey(fromJson: _dateTimeFromTimestamp, includeFromJson: true, toJson: _dateTimeToTimestamp, includeToJson: true) DateTime bossStartAt
});




}
/// @nodoc
class __$WorldBossModelCopyWithImpl<$Res>
    implements _$WorldBossModelCopyWith<$Res> {
  __$WorldBossModelCopyWithImpl(this._self, this._then);

  final _WorldBossModel _self;
  final $Res Function(_WorldBossModel) _then;

/// Create a copy of WorldBossModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? capacity = null,Object? joinedCount = null,Object? bossStartAt = null,}) {
  return _then(_WorldBossModel(
capacity: null == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int,joinedCount: null == joinedCount ? _self.joinedCount : joinedCount // ignore: cast_nullable_to_non_nullable
as int,bossStartAt: null == bossStartAt ? _self.bossStartAt : bossStartAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
