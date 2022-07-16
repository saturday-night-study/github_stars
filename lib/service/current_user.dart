import 'package:github_stars/models/token.dart';
import 'package:github_stars/store/data_keys.dart';
import 'package:github_stars/store/data_storage.dart';

class CurrentUser {
  static final _instance = CurrentUser._internal();

  factory CurrentUser() {
    return _instance;
  }

  CurrentUser._internal();

  Token? _token;

  Future<void> loadToken() async {
    _token = Token.of(await DataStorage().read(kGithubToken));
  }

  Future<void> updateToken(Token token) async {
    _token = token;

    await DataStorage().write(kGithubToken, token.value);
  }

  Future<void> clearToken() async {
    _token = null;

    await DataStorage().delete(kGithubToken);

    print(await DataStorage().read(kGithubToken));
  }

  bool get isSignIn => _token != null && _token!.exists;
  bool get isSignOut => !isSignIn;
  String get token => _token?.value ?? "";
}
