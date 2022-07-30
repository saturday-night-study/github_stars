import 'package:github_stars/models/bind_helper.dart';

class Repository with BindHelper {
  Repository(Map<String, dynamic> json) {
    name = getString(json, "name");
    fullName = getString(json, "full_name");
    url = getString(json, "html_url");
    description = getString(json, "description");
    language = getString(json, "language");
    stars = getInt(json, "stargazers_count");
    forks = getInt(json, "forks_count");
    updateAt = getDateTime(json, "updated_at");
  }

  factory Repository.fromJson(dynamic json) {
    return Repository(json as Map<String, dynamic>);
  }

  late final String name;
  late final String fullName;
  late final String url;
  late final String description;
  late final String language;
  late final int stars;
  late final int forks;
  late final DateTime? updateAt;

  @override
  String toString() {
    return """{
    name: "$name",
    fullName: "$fullName",
    url: "$url",
    description: "$description",
    language: "$language",
    stars: "$stars",
    forks: "$forks",
    updateAt: "$updateAt",
}""";
  }
}
