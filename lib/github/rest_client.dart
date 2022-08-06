import 'package:dio/dio.dart';
import 'package:github_stars/models/repository.dart';
import 'package:github_stars/models/user.dart';
import 'package:github_stars/service/current_user.dart';

class RestClient {
  static const _apiUrlPrefix = "https://api.github.com/";
  static const _apiHeaderAccept = "application/vnd.github+json";
  static const _apiHeaderStarAccept = "application/vnd.github.star+json";

  String _uri(String uriPath) => "$_apiUrlPrefix$uriPath";

  Options _options([String accept = _apiHeaderAccept]) {
    return Options(
      headers: {
        "Accept": accept,
        "Authorization": "token ${CurrentUser().token}",
      },
    );
  }

  Future<User?> getUser() async {
    try {
      final response = await Dio().get(
        _uri("user"),
        options: _options(),
      );

      final json = response.data as Map<String, dynamic>;

      return User.fromJson(json);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Repository>> getUserRepositories() async {
    try {
      final response = await Dio().get(
        _uri("user/repos?sort=updated"),
        options: _options(),
      );

      final list = response.data as List<dynamic>;

      return list.map((json) => Repository.fromJson(json)).toList();
    } catch (e) {
      print(e);
      return List.empty();
    }
  }

  Future<List<Repository>> getUserStars({
    required int page,
    required int perPage,
  }) async {
    try {
      final response = await Dio().get(
        _uri("user/starred?page=$page&per_page=$perPage"),
        options: _options(),
      );

      final list = response.data as List<dynamic>;

      return list.map((json) => Repository.fromJson(json)).toList();
    } catch (e) {
      print(e);
      return List.empty();
    }
  }

  Future<void> deleteUserStar(Repository repository) async {
    try {
      await Dio().delete(
        _uri("user/starred/${repository.ownerId}/${repository.name}"),
        options: _options(_apiHeaderStarAccept),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> putUserStar(Repository repository) async {
    try {
      await Dio().put(
        _uri("user/starred/${repository.ownerId}/${repository.name}"),
        options: _options(_apiHeaderStarAccept),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<List<Repository>> search(String keyword) async {
    try {
      final response = await Dio().get(
        _uri("search/repositories?q=${Uri.encodeComponent(keyword)}"),
        options: _options(),
      );

      final result = response.data as Map<String, dynamic>;
      final items = result["items"] as List<dynamic>;

      return items.map((json) => Repository.fromJson(json)).toList();
    } catch (e) {
      print(e);
      return List.empty();
    }
  }
}
