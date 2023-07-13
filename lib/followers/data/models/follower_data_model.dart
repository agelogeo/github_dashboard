import 'package:json_annotation/json_annotation.dart';

part 'follower_data_model.g.dart';

@JsonSerializable()
class FollowerData {
  String? name;
  String login;
  @JsonKey(name: 'avatar_url')
  String avatarUrl;

  FollowerData({
    this.name,
    required this.login,
    required this.avatarUrl,
  });

  factory FollowerData.fromJson(Map<String, dynamic> json) =>
      _$FollowerDataFromJson(json);

  Map<String, dynamic> toJson() => _$FollowerDataToJson(this);
}
