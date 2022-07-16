import 'package:flutter/material.dart';
import 'package:github_stars/pages/signin_page.dart';
import 'package:github_stars/theme.dart';

class GithubStarsApp extends StatelessWidget {
  const GithubStarsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SignInPage(),
      theme: theme,
    );
  }
}
