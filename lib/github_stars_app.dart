import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:github_stars/pages/signin_page.dart';
import 'package:github_stars/theme.dart';

class GithubStarsApp extends StatelessWidget {
  const GithubStarsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SignInPage(),
      theme: theme,
    );
  }
}
