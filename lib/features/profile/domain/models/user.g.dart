// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  id: json['id'] as String,
  name: json['name'] as String,
  email: json['email'] as String,
  points: (json['points'] as num).toInt(),
  role: json['role'] as String,
  avatar: json['avatar'] as String?,
  bio: json['bio'] as String?,
  location: json['location'] as String?,
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'points': instance.points,
  'role': instance.role,
  'avatar': instance.avatar,
  'bio': instance.bio,
  'location': instance.location,
};
