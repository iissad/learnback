// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_skill.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserSkill {

 String get id; String get userId; String get skillId; String get level; String get source;
/// Create a copy of UserSkill
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSkillCopyWith<UserSkill> get copyWith => _$UserSkillCopyWithImpl<UserSkill>(this as UserSkill, _$identity);

  /// Serializes this UserSkill to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSkill&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.skillId, skillId) || other.skillId == skillId)&&(identical(other.level, level) || other.level == level)&&(identical(other.source, source) || other.source == source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,skillId,level,source);

@override
String toString() {
  return 'UserSkill(id: $id, userId: $userId, skillId: $skillId, level: $level, source: $source)';
}


}

/// @nodoc
abstract mixin class $UserSkillCopyWith<$Res>  {
  factory $UserSkillCopyWith(UserSkill value, $Res Function(UserSkill) _then) = _$UserSkillCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String skillId, String level, String source
});




}
/// @nodoc
class _$UserSkillCopyWithImpl<$Res>
    implements $UserSkillCopyWith<$Res> {
  _$UserSkillCopyWithImpl(this._self, this._then);

  final UserSkill _self;
  final $Res Function(UserSkill) _then;

/// Create a copy of UserSkill
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? skillId = null,Object? level = null,Object? source = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,skillId: null == skillId ? _self.skillId : skillId // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UserSkill].
extension UserSkillPatterns on UserSkill {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserSkill value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserSkill() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserSkill value)  $default,){
final _that = this;
switch (_that) {
case _UserSkill():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserSkill value)?  $default,){
final _that = this;
switch (_that) {
case _UserSkill() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String skillId,  String level,  String source)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserSkill() when $default != null:
return $default(_that.id,_that.userId,_that.skillId,_that.level,_that.source);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String skillId,  String level,  String source)  $default,) {final _that = this;
switch (_that) {
case _UserSkill():
return $default(_that.id,_that.userId,_that.skillId,_that.level,_that.source);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String skillId,  String level,  String source)?  $default,) {final _that = this;
switch (_that) {
case _UserSkill() when $default != null:
return $default(_that.id,_that.userId,_that.skillId,_that.level,_that.source);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserSkill implements UserSkill {
  const _UserSkill({required this.id, required this.userId, required this.skillId, required this.level, required this.source});
  factory _UserSkill.fromJson(Map<String, dynamic> json) => _$UserSkillFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String skillId;
@override final  String level;
@override final  String source;

/// Create a copy of UserSkill
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserSkillCopyWith<_UserSkill> get copyWith => __$UserSkillCopyWithImpl<_UserSkill>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserSkillToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserSkill&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.skillId, skillId) || other.skillId == skillId)&&(identical(other.level, level) || other.level == level)&&(identical(other.source, source) || other.source == source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,skillId,level,source);

@override
String toString() {
  return 'UserSkill(id: $id, userId: $userId, skillId: $skillId, level: $level, source: $source)';
}


}

/// @nodoc
abstract mixin class _$UserSkillCopyWith<$Res> implements $UserSkillCopyWith<$Res> {
  factory _$UserSkillCopyWith(_UserSkill value, $Res Function(_UserSkill) _then) = __$UserSkillCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String skillId, String level, String source
});




}
/// @nodoc
class __$UserSkillCopyWithImpl<$Res>
    implements _$UserSkillCopyWith<$Res> {
  __$UserSkillCopyWithImpl(this._self, this._then);

  final _UserSkill _self;
  final $Res Function(_UserSkill) _then;

/// Create a copy of UserSkill
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? skillId = null,Object? level = null,Object? source = null,}) {
  return _then(_UserSkill(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,skillId: null == skillId ? _self.skillId : skillId // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
