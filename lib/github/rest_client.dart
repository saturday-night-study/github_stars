import 'package:dio/dio.dart';
import 'package:github_stars/models/user.dart';
import 'package:github_stars/service/current_user.dart';

class RestClient {
  static const _apiUrlPrefix = "https://api.github.com/";
  static const _apiHeaderAccept = "application/vnd.github+json";

  String _uri(String uriPath) => "$_apiUrlPrefix$uriPath";
  Options _options(String token) {
    return Options(
      headers: {
        "Accept": _apiHeaderAccept,
        "Authorization": "token $token",
      },
    );
  }

  Future<User?> getUser() async {
    try {
      final response = await Dio().get(
        _uri("user"),
        options: _options(CurrentUser().token),
      );

      final json = response.data as Map<String, dynamic>;

      return User.fromJson(json);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
