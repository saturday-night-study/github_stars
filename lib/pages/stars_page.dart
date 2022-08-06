import 'package:flutter/material.dart';
import 'package:github_stars/github/rest_client.dart';
import 'package:github_stars/models/repository.dart';
import 'package:github_stars/pages/webview_page.dart';
import 'package:github_stars/theme.dart';
import 'package:github_stars/widgets/github_appbar.dart';
import 'package:github_stars/widgets/repository_list_item.dart';

class StarsPage extends StatefulWidget {
  const StarsPage({Key? key}) : super(key: key);

  @override
  State<StarsPage> createState() => _StarsPageState();
}

class _StarsPageState extends State<StarsPage> {
  List<Repository> _repositories = List.empty();
  bool _isDataLoading = true;

  @override
  void initState() {
    super.initState();

    _loadDatas();
  }

  Future<void> _loadDatas() async {
    final repositories = await RestClient().getUserStars(page: 1, perPage: 100);

    setState(() {
      _repositories = repositories;
      _isDataLoading = false;
    });
  }

  void _handleRepositoryTap(Repository repository) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewPage(url: repository.url),
      ),
    );
  }

  void _handleUnstarTap(Repository repository) async {
    await RestClient().deleteUserStar(repository);

    setState(() {
      _repositories = _repositories
          .where((r) => r.fullName != repository.fullName)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GithubAppBar(),
      backgroundColor: Colors.grey.shade100,
      body: _createBody(),
    );
  }

  Widget _createBody() {
    if (_isDataLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: primaryColor,
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
      itemCount: _repositories.length,
      itemBuilder: (_, index) {
        final repoIndex = index;
        final hadDivider = repoIndex != _repositories.length - 1;

        return RepositoryListItem(
          onTap: _handleRepositoryTap,
          onUnstar: _handleUnstarTap,
          repository: _repositories[repoIndex],
          useStarButton: true,
          hasDivider: hadDivider,
        );
      },
    );
  }
}

// 더 보기 처리
