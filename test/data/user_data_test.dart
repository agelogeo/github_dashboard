import 'dart:convert';
import 'dart:io';
import 'package:github_dashboard/user/data/models/user_data_model.dart';
import 'package:test/test.dart';

void main() {
  group('UserData', () {
    test('should parse JSON correctly', () async {
      // Read the JSON file
      final file = File('test/json/user_response.json');
      final json = await file.readAsString();

      // Decode the JSON to a Map
      final data = jsonDecode(json) as Map<String, dynamic>;

      // Create a UserData from the JSON data
      final userData = UserData.fromJson(data);

      // Check the values
      expect(userData.login, 'c9s');
      expect(userData.avatarUrl,
          'https://avatars.githubusercontent.com/u/50894?v=4');
      expect(userData.url, 'https://api.github.com/users/c9s');
      expect(userData.htmlUrl, 'https://github.com/c9s');
      expect(
          userData.followersUrl, 'https://api.github.com/users/c9s/followers');
      expect(userData.reposUrl, 'https://api.github.com/users/c9s/repos');
      expect(userData.name, null);
      expect(userData.company, null);
      expect(userData.location, 'Taipei, Taiwan');
      expect(userData.email, null);
      expect(userData.bio, 'a developer who really loves crafting tools\r\n');
      expect(userData.publicRepos, 435);
      expect(userData.followers, 2443);
      expect(userData.createdAt, DateTime.parse('2009-02-01T15:20:08Z'));
    });
  });
}
