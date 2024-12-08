// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterInfo _$RegisterInfoFromJson(Map<String, dynamic> json) => RegisterInfo(
      id: json['id'] as String,
      pwd: json['pwd'] as String,
    );

Map<String, dynamic> _$RegisterInfoToJson(RegisterInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pwd': instance.pwd,
    };

LoginInfo _$LoginInfoFromJson(Map<String, dynamic> json) => LoginInfo(
      id: json['id'] as String,
      pwd: json['pwd'] as String,
    );

Map<String, dynamic> _$LoginInfoToJson(LoginInfo instance) => <String, dynamic>{
      'id': instance.id,
      'pwd': instance.pwd,
    };

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      id: json['id'] as String,
      pwd: json['pwd'] as String,
      rating: (json['rating'] as num).toInt(),
      key: json['key'] as String,
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'id': instance.id,
      'pwd': instance.pwd,
      'rating': instance.rating,
      'key': instance.key,
    };

UserKeyInfo _$UserKeyInfoFromJson(Map<String, dynamic> json) => UserKeyInfo(
      key: json['key'] as String,
    );

Map<String, dynamic> _$UserKeyInfoToJson(UserKeyInfo instance) =>
    <String, dynamic>{
      'key': instance.key,
    };

NotationInfo _$NotationInfoFromJson(Map<String, dynamic> json) => NotationInfo(
      color: (json['color'] as num).toInt(),
      x: (json['x'] as num).toInt(),
      y: (json['y'] as num).toInt(),
    );

Map<String, dynamic> _$NotationInfoToJson(NotationInfo instance) =>
    <String, dynamic>{
      'color': instance.color,
      'x': instance.x,
      'y': instance.y,
    };

GameInfo _$GameInfoFromJson(Map<String, dynamic> json) => GameInfo(
      result: json['result'] as String,
      blackname: json['blackname'] as String,
      blackrating: (json['blackrating'] as num).toInt(),
      whitename: json['whitename'] as String,
      whiterating: (json['whiterating'] as num).toInt(),
      notations: (json['notations'] as List<dynamic>)
          .map((e) => NotationInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GameInfoToJson(GameInfo instance) => <String, dynamic>{
      'result': instance.result,
      'blackname': instance.blackname,
      'blackrating': instance.blackrating,
      'whitename': instance.whitename,
      'whiterating': instance.whiterating,
      'notations': instance.notations,
    };

GameCommandInfo _$GameCommandInfoFromJson(Map<String, dynamic> json) =>
    GameCommandInfo(
      side: (json['side'] as num).toInt(),
      command: json['command'] as String,
      notation: NotationInfo.fromJson(json['notation'] as Map<String, dynamic>),
      message: json['message'] as String,
    );

Map<String, dynamic> _$GameCommandInfoToJson(GameCommandInfo instance) =>
    <String, dynamic>{
      'side': instance.side,
      'command': instance.command,
      'notation': instance.notation,
      'message': instance.message,
    };

GameResponseInfo _$GameResponseInfoFromJson(Map<String, dynamic> json) =>
    GameResponseInfo(
      command: json['command'] as String,
      notation: NotationInfo.fromJson(json['notation'] as Map<String, dynamic>),
      message: json['message'] as String,
    );

Map<String, dynamic> _$GameResponseInfoToJson(GameResponseInfo instance) =>
    <String, dynamic>{
      'command': instance.command,
      'notation': instance.notation,
      'message': instance.message,
    };

TimeControl _$TimeControlFromJson(Map<String, dynamic> json) => TimeControl(
      seconds: (json['seconds'] as num).toInt(),
      fisher: (json['fisher'] as num).toInt(),
    );

Map<String, dynamic> _$TimeControlToJson(TimeControl instance) =>
    <String, dynamic>{
      'seconds': instance.seconds,
      'fisher': instance.fisher,
    };
