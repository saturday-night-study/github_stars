import 'package:flutter/material.dart';
import 'package:github_stars/github/rest_client.dart';
import 'package:github_stars/widgets/github_appbar.dart';

class StarsPage extends StatefulWidget {
  const StarsPage({Key? key}) : super(key: key);

  @override
  State<StarsPage> createState() => _StarsPageState();
}

class _StarsPageState extends State<StarsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GithubAppBar(),
      body: Container(
        color: Colors.orangeAccent,
      ),
    );
  }
}
