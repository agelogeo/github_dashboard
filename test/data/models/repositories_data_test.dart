import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_dashboard/followers/data/models/follower_data_model.dart';
import 'package:github_dashboard/repositories/data/models/repository_data_model.dart';

void main() {
  group('RepositoriesData', () {
    test('should parse JSON array correctly', () async {
      final file = File('test/json/repositories_response.json');
      final json = await file.readAsString();

      final data = jsonDecode(json) as List;

      final followerDataList =
          data.map((item) => RepositoryData.fromJson(item)).toList();

      expect(followerDataList[0].id, 460428);
      expect(followerDataList[0].name, 'ack.vim');
      expect(followerDataList[0].description,
          'Vim plugin for the Perl module / CLI script \'ack\'');
      expect(followerDataList[0].stargazersCount, 3);
      expect(
          followerDataList[0].url, 'https://api.github.com/repos/c9s/ack.vim');
    });
  });
}
