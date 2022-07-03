import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:github_stars/github/github_config.dart';

class GithubOAuthHelper {
  GithubOAuthHelper._internal();

  static Future<String?> signInWithGitHub(BuildContext context) async {
    final GitHubSignIn gitHubSignIn = GitHubSignIn(
      clientId: clientId,
      clientSecret: clientSecret,
      redirectUrl: callbackUrl,
    );

    final result = await gitHubSignIn.signIn(context);
    if (result.status != GitHubSignInResultStatus.ok) {
      return null;
    }

    return result.token;
  }
}
