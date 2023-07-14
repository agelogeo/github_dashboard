import 'package:github_dashboard/repositories/domain/entities/repository_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'repository_data_model.g.dart';

@JsonSerializable()
class RepositoryData {
  final int id;
  final String name;
  final String url;
  @JsonKey(name: 'html_url')
  final String htmlUrl;
  final String? description;
  @JsonKey(name: 'stargazers_count')
  final int stargazersCount;

  RepositoryData({
    required this.id,
    required this.name,
    required this.url,
    required this.htmlUrl,
    required this.stargazersCount,
    this.description,
  });

  Repository toDomainModel() {
    return Repository(
      id: id,
      name: name,
      url: url,
      htmlUrl: htmlUrl,
      description: description,
      stargazersCount: stargazersCount,
    );
  }

  factory RepositoryData.fromJson(Map<String, dynamic> json) =>
      _$RepositoryDataFromJson(json);

  Map<String, dynamic> toJson() => _$RepositoryDataToJson(this);
}
