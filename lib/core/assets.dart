abstract class Assets {
  static const _assetsPath = 'assets/';

  static const illustrations = _Illustrations(_assetsPath);
  static const icons = _Icons(_assetsPath);
}

class _Illustrations {
  static const _path = 'illustrations/';

  final String noData;
  final String welcome;
  final String wait;

  const _Illustrations(String assetsPath)
      : noData = '$assetsPath${_path}no_data.svg',
        welcome = '$assetsPath${_path}hello.svg',
        wait = '$assetsPath${_path}wait.svg';
}

class _Icons {
  static const _path = 'icons/';

  final String github;

  const _Icons(String assetsPath)
      : github = '$assetsPath${_path}github_logo.png';
}
