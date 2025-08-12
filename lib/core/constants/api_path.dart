import 'package:envied/envied.dart';

import 'environment_files.dart';

part 'api_path.g.dart';

@Envied(path: pathToEnv, requireEnvFile: true)
class ApiPath {
  /// Base URL
  @EnviedField(varName: 'BASE_URL', obfuscate: true)
  static String baseUrl = _ApiPath.baseUrl;

  static const String refreshToken = '/refresh-token';
  static const String login = '/login';
}