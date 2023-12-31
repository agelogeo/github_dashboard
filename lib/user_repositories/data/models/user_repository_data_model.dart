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
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  UserRepositoryData({
    required this.id,
    required this.name,
    required this.url,
    required this.htmlUrl,
    required this.stargazersCount,
    required this.updatedAt,
    required this.createdAt,
    this.description,
  });

  UserRepository toDomainModel() {
    return UserRepository(
      id: id,
      name: name,
      url: url,
      htmlUrl: htmlUrl,
      description: description,
      updatedAt: updatedAt,
      createdAt: createdAt,
      stargazersCount: stargazersCount,
    );
  }

  factory UserRepositoryData.fromJson(Map<String, dynamic> json) =>
      _$UserRepositoryDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserRepositoryDataToJson(this);
}
