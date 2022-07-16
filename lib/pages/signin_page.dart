import 'package:flutter/material.dart';
import 'package:github_stars/github/oauth_helper.dart';
import 'package:github_stars/pages/home_page.dart';
import 'package:github_stars/service/current_user.dart';
import 'package:github_stars/theme.dart';
import 'package:github_stars/widgets/github_appbar.dart';
import 'package:github_stars/widgets/toast.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isGithubSigninProgress = false;
  set isGithubSigninProgress(bool newValue) {
    setState(() {
      _isGithubSigninProgress = newValue;
    });
  }

  @override
  void initState() {
    super.initState();

    _loadToken();
  }

  Future<void> _loadToken() async {
    isGithubSigninProgress = true;
    await CurrentUser().loadToken();
    isGithubSigninProgress = false;

    _goToHome();
  }

  Future<void> _handleSigninWithGithub() async {
    isGithubSigninProgress = true;
    final token = await GithubOAuthHelper.signInWithGitHub(context);
    isGithubSigninProgress = false;

    if (token.notExists) {
      Toast.show("Github 인증에 실패했습니다.");
      return;
    }

    CurrentUser().updateToken(token);

    Toast.show("Github 인증에 성공했습니다.");

    _goToHome();
  }

  Future<void> _goToHome() async {
    if (CurrentUser().isSignOut) {
      return;
    }

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) {
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GithubAppBar(),
      body: Stack(
        children: [
          _createLogo(),
          _createSigninButton(),
        ],
      ),
    );
  }

  Widget _createLogo() {
    return Align(
      alignment: Alignment.center,
      child: Image.asset(
        "assets/images/github-icon-black.png",
        alignment: Alignment.topCenter,
        width: 58,
        height: 160,
      ),
    );
  }

  Widget _createSigninButton() {
    final child = !_isGithubSigninProgress
        ? const Text("Sign in with GitHub")
        : const SizedBox(
            width: 20,
            height: 20,
            child: LoadingIndicator(
              indicatorType: Indicator.circleStrokeSpin,
              colors: [Colors.white],
              strokeWidth: 2,
            ),
          );

    return Positioned(
      bottom: 80,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: IgnorePointer(
          ignoring: _isGithubSigninProgress,
          child: ElevatedButton(
            onPressed: _handleSigninWithGithub,
            style: ElevatedButton.styleFrom(
              primary: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
