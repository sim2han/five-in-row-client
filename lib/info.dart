import 'package:json_annotation/json_annotation.dart';
part 'info.g.dart';

// dart run build_runner build

@JsonSerializable()
class RegisterInfo {
  final String id;
  final String pwd;

  RegisterInfo({required this.id, required this.pwd});
  factory RegisterInfo.fromJson(Map<String, dynamic> json) =>
      _$RegisterInfoFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterInfoToJson(this);
}

@JsonSerializable()
class LoginInfo {
  final String id;
  final String pwd;

  LoginInfo({required this.id, required this.pwd});
  factory LoginInfo.fromJson(Map<String, dynamic> json) =>
      _$LoginInfoFromJson(json);
  Map<String, dynamic> toJson() => _$LoginInfoToJson(this);
}

@JsonSerializable()
class UserInfo {
  final String id;
  final String pwd;
  final int rating;
  final String key;

  UserInfo(
      {required this.id,
      required this.pwd,
      required this.rating,
      required this.key});
  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

@JsonSerializable()
class UserKeyInfo {
  final String key;

  UserKeyInfo({required this.key});
  factory UserKeyInfo.fromJson(Map<String, dynamic> json) =>
      _$UserKeyInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserKeyInfoToJson(this);
}

@JsonSerializable()
class NotationInfo {
  final int color;
  final int x;
  final int y;

  NotationInfo({required this.color, required this.x, required this.y});
  factory NotationInfo.fromJson(Map<String, dynamic> json) =>
      _$NotationInfoFromJson(json);
  Map<String, dynamic> toJson() => _$NotationInfoToJson(this);
}

@JsonSerializable()
class GameInfo {
  final String result;
  final String blackname;
  final int blackrating;
  final String whitename;
  final int whiterating;
  final List<NotationInfo> notations;

  GameInfo(
      {required this.result,
      required this.blackname,
      required this.blackrating,
      required this.whitename,
      required this.whiterating,
      required this.notations});
  factory GameInfo.fromJson(Map<String, dynamic> json) =>
      _$GameInfoFromJson(json);
  Map<String, dynamic> toJson() => _$GameInfoToJson(this);
}

@JsonSerializable()
class GameCommandInfo {
  final int side;
  final String command;
  final NotationInfo notation;
  final String message;

  GameCommandInfo(
      {required this.side,
      required this.command,
      required this.notation,
      required this.message});
  factory GameCommandInfo.fromJson(Map<String, dynamic> json) =>
      _$GameCommandInfoFromJson(json);
  Map<String, dynamic> toJson() => _$GameCommandInfoToJson(this);
}

@JsonSerializable()
class GameResponseInfo {
  final String command;
  final NotationInfo notation;
  final String message;

  GameResponseInfo(
      {required this.command, required this.notation, required this.message});
  factory GameResponseInfo.fromJson(Map<String, dynamic> json) =>
      _$GameResponseInfoFromJson(json);
  Map<String, dynamic> toJson() => _$GameResponseInfoToJson(this);
}

@JsonSerializable()
class TimeControl {
  final int seconds, fisher;
  TimeControl({required this.seconds, required this.fisher});
  factory TimeControl.fromJson(Map<String, dynamic> json) =>
      _$TimeControlFromJson(json);
  Map<String, dynamic> toJson() => _$TimeControlToJson(this);
}
