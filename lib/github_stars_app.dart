import 'package:flutter/material.dart';
import 'package:github_stars/pages/home_page.dart';

class GithubStarsApp extends StatelessWidget {
  const GithubStarsApp({Key? key}) : super(key: key);

  static const primaryColor = Color(0xff24292f);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
          appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
      )),
    );
  }
}
