import 'package:github_stars/models/bind_helper.dart';

class User with BindHelper {
  User(Map<String, dynamic> json) {
    userID = getString(json, "login");
    userName = getString(json, "name");
    avatarUrl = getString(json, "avatar_url");
    githubUrl = getString(json, "html_url");
    blogUrl = getString(json, "blog");
    company = getString(json, "company");
    location = getString(json, "location");
    email = getString(json, "email");
    bio = getString(json, "bio");
    followers = getInt(json, "followers");
    following = getInt(json, "following");
  }

  factory User.fromJson(dynamic json) {
    return User(json as Map<String, dynamic>);
  }

  late final String userID;
  late final String userName;
  late final String avatarUrl;
  late final String githubUrl;
  late final String blogUrl;
  late final String company;
  late final String location;
  late final String email;
  late final String bio;
  late final int followers;
  late final int following;

  @override
  String toString() {
    return """{
    userID: "$userID",
    userName: "$userName",
    avatarUrl: "$avatarUrl",
    githubUrl: "$githubUrl",
    blogUrl: "$blogUrl",
    company: "$company",
    location: "$location",
    email: "$email",
    bio: "$bio",
    followers: "$followers",
    following: "$following",
}""";
  }
}
