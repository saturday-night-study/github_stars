import 'package:flutter/material.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:github_stars/github/oauth_config.dart';
import 'package:github_stars/models/token.dart';

class GithubOAuthHelper {
  GithubOAuthHelper._internal();

  static Future<Token> signInWithGitHub(BuildContext context) async {
    final GitHubSignIn gitHubSignIn = GitHubSignIn(
      clientId: clientId,
      clientSecret: clientSecret,
      redirectUrl: callbackUrl,
    );

    final result = await gitHubSignIn.signIn(context);
    if (result.status != GitHubSignInResultStatus.ok) {
      return Token.empty();
    }

    return Token.of(result.token);
  }
}
