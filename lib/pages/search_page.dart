import 'package:flutter/material.dart';
import 'package:github_stars/widgets/github_appbar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GithubAppBar(),
      body: Container(
        color: Colors.blueAccent,
      ),
    );
  }
}
