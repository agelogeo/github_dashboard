import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_dashboard/followers/data/models/follower_data_model.dart';

void main() {
  group('FollowerData', () {
    test('should parse JSON array correctly', () async {
      final file = File('test/json/followers_response.json');
      final json = await file.readAsString();

      final data = jsonDecode(json) as List;

      final followerDataList =
          data.map((item) => FollowerData.fromJson(item)).toList();

      expect(followerDataList[0].name, null);
      expect(followerDataList[0].login, 'melo');
      expect(followerDataList[0].avatarUrl,
          'https://avatars.githubusercontent.com/u/485?v=4');

      expect(followerDataList[1].name, null);
      expect(followerDataList[1].login, 'komapa');
      expect(followerDataList[1].avatarUrl,
          'https://avatars.githubusercontent.com/u/577?v=4');
    });
  });
}
