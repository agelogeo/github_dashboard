class Repository {
  final int id;
  final String name;
  final String url;
  final String htmlUrl;
  final String? description;
  final int stargazersCount;

  Repository({
    required this.id,
    required this.name,
    required this.url,
    required this.htmlUrl,
    required this.stargazersCount,
    this.description,
  });
}
