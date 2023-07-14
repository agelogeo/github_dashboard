import 'package:github_dashboard/user/domain/entities/user_entity.dart';
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

  User toDomainModel() {
    return User(
      name: name,
      createdAt: createdAt,
      followersUrl: followersUrl,
      htmlUrl: htmlUrl,
      login: login,
      avatarUrl: avatarUrl,
      location: location,
      bio: bio,
      publicRepos: publicRepos,
      followers: followers,
      reposUrl: reposUrl,
      url: url,
      company: company,
      email: email,
    );
  }

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
