import 'package:github_dashboard/user_repositories/domain/entities/user_repository_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_repository_data_model.g.dart';

@JsonSerializable()
class UserRepositoryData {
  final int id;
  final String name;
  final String url;
  @JsonKey(name: 'html_url')
  final String htmlUrl;
  final String? description;
  @JsonKey(name: 'stargazers_count')
  final int stargazersCount;

  UserRepositoryData({
    required this.id,
    required this.name,
    required this.url,
    required this.htmlUrl,
    required this.stargazersCount,
    this.description,
  });

  UserRepository toDomainModel() {
    return UserRepository(
      id: id,
      name: name,
      url: url,
      htmlUrl: htmlUrl,
      description: description,
      stargazersCount: stargazersCount,
    );
  }

  factory UserRepositoryData.fromJson(Map<String, dynamic> json) =>
      _$UserRepositoryDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserRepositoryDataToJson(this);
}
