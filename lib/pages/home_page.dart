import 'package:flutter/material.dart';
import 'package:github_stars/github/oauth_helper.dart';
import 'package:github_stars/models/token.dart';
import 'package:github_stars/theme.dart';
import 'package:github_stars/widgets/github_appbar.dart';
import 'package:github_stars/widgets/toast.dart';
import 'package:loading_indicator/loading_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Token? _token;
  bool get _hasToken => _token != null;

  bool _isGithubSigninProgress = false;
  set isGithubSigninProgress(bool newValue) {
    setState(() {
      _isGithubSigninProgress = newValue;
    });
  }

  void _handleSigninWithGithub() async {
    isGithubSigninProgress = true;
    final token = await GithubOAuthHelper.signInWithGitHub(context);
    // await Future.delayed(const Duration(seconds: 3));
    isGithubSigninProgress = false;

    if (token.notExists) {
      Toast.show("Github 인증에 실패했습니다.");
      return;
    }

    setState(() {
      _token = token;
    });

    Toast.show("Github 인증에 성공했습니다.");
  }

  void _handlePrintToken() {
    print("token=[$_token]");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GithubAppBar(),
      body: Center(
        child: _createButtons(),
      ),
    );
  }

  Widget _createButtons() {
    final signinButtonChild = _isGithubSigninProgress
        ? const SizedBox(
            width: 20,
            height: 20,
            child: LoadingIndicator(
              indicatorType: Indicator.circleStrokeSpin,
              colors: [primaryColor],
              strokeWidth: 2,
            ),
          )
        : const Text("GitHub signin test");

    return SizedBox(
      width: 200,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IgnorePointer(
            ignoring: _isGithubSigninProgress,
            child: OutlinedButton(
              onPressed: _handleSigninWithGithub,
              child: signinButtonChild,
            ),
          ),
          Visibility(
            visible: _hasToken,
            child: OutlinedButton(
              onPressed: _handlePrintToken,
              child: const Text("Print token"),
            ),
          ),
        ],
      ),
    );
  }
}
