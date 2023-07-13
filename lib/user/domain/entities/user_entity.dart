class User {
  String login;
  String avatarUrl;
  String url;
  String htmlUrl;
  String followersUrl;
  String reposUrl;
  String? name;
  String? company;
  String? location;
  String? email;
  String? bio;
  int publicRepos;
  int followers;
  DateTime createdAt;

  User({
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
}
