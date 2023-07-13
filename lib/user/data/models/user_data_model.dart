import 'package:json_annotation/json_annotation.dart';

part 'user_data_model.g.dart';

@JsonSerializable()
class UserData {
  String login;
  @JsonKey(name: 'avatar_url')
  String avatarUrl;
  String url;
  @JsonKey(name: 'html_url')
  String htmlUrl;
  @JsonKey(name: 'followers_url')
  String followersUrl;
  @JsonKey(name: 'repos_url')
  String reposUrl;
  String? name;
  String? company;
  String? location;
  String? email;
  String? bio;
  @JsonKey(name: 'public_repos')
  int publicRepos;
  int followers;
  @JsonKey(name: 'created_at')
  DateTime createdAt;

  UserData({
    required this.login,
    required this.avatarUrl,
    required this.url,
    required this.htmlUrl,
    required this.followersUrl,
    required this.reposUrl,
    this.name,
    this.company,
    this.location,
    this.email,
    this.bio,
    required this.publicRepos,
    required this.followers,
    required this.createdAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
