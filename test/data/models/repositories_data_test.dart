import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_dashboard/user_repositories/data/models/user_repository_data_model.dart';

void main() {
  group('RepositoriesData', () {
    test('should parse JSON array correctly', () async {
      final file = File('test/json/repositories_response.json');
      final json = await file.readAsString();

      final data = jsonDecode(json) as List;

      final repoDataList =
          data.map((item) => UserRepositoryData.fromJson(item)).toList();

      expect(repoDataList[0].id, 460428);
      expect(repoDataList[0].name, 'ack.vim');
      expect(repoDataList[0].description,
          'Vim plugin for the Perl module / CLI script \'ack\'');
      expect(repoDataList[0].stargazersCount, 3);
      expect(repoDataList[0].url, 'https://api.github.com/repos/c9s/ack.vim');
    });
  });
}
