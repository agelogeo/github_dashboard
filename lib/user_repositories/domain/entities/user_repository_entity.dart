class UserRepository {
  final int id;
  final String name;
  final String url;
  final String htmlUrl;
  final String? description;
  final int stargazersCount;
  final DateTime updatedAt;

  UserRepository({
    required this.id,
    required this.name,
    required this.url,
    required this.htmlUrl,
    required this.stargazersCount,
    required this.updatedAt,
    this.description,
  });
}
