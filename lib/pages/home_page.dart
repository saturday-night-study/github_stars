import 'package:flutter/material.dart';
import 'package:github_stars/github/rest_client.dart';
import 'package:github_stars/models/token.dart';
import 'package:github_stars/pages/signin_page.dart';
import 'package:github_stars/service/current_user.dart';
import 'package:github_stars/widgets/github_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _handleGetUserProfile() async {
    final user = await RestClient().getUser();
    if (user == null) {
      return;
    }

    print(user);
  }

  Future<void> _handleSignOut() async {
    await CurrentUser().clearToken();

    _goToSignInPage();
  }

  void _goToSignInPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignInPage()),
    );
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
    return SizedBox(
      width: 200,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OutlinedButton(
            onPressed: _handleGetUserProfile,
            child: const Text("Get User Profile"),
          ),
          OutlinedButton(
            onPressed: _handleSignOut,
            child: const Text("Sign Out"),
          ),
        ],
      ),
    );
  }
}
