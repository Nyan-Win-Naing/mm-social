// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationVO _$ConversationVOFromJson(Map<String, dynamic> json) =>
    ConversationVO(
      userVo: json['userVo'] == null
          ? null
          : UserVO.fromJson(json['userVo'] as Map<String, dynamic>),
      message: json['message'] as String?,
      timestamp: json['timestamp'] as int?,
    );

Map<String, dynamic> _$ConversationVOToJson(ConversationVO instance) =>
    <String, dynamic>{
      'userVo': instance.userVo,
      'message': instance.message,
      'timestamp': instance.timestamp,
    };
