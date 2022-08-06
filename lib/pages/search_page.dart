import 'package:flutter/material.dart';
import 'package:github_stars/github/rest_client.dart';
import 'package:github_stars/models/repository.dart';
import 'package:github_stars/pages/webview_page.dart';
import 'package:github_stars/theme.dart';
import 'package:github_stars/widgets/github_appbar.dart';
import 'package:github_stars/widgets/repository_list_item.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Repository> _repositories = List.empty();
  bool _isDataLoading = false;

  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }

  void _handleRepositoryTap(Repository repository) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewPage(url: repository.url),
      ),
    );
  }

  Future<void> _handleSearch() async {
    FocusManager.instance.primaryFocus?.unfocus();

    setState(() {
      _isDataLoading = true;
    });

    final keyword = _controller.text.trim();
    final repositories = await RestClient().search(keyword);

    setState(() {
      _repositories = repositories;
      _isDataLoading = false;
    });
  }

  void _handleStarTap(Repository repository) async {
    await RestClient().putUserStar(repository);
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
    return Column(
      children: [
        _createSearchBar(),
        _createList(),
      ],
    );
  }

  Widget _createList() {
    if (_isDataLoading) {
      return const Expanded(
        child: Center(
          child: CircularProgressIndicator(
            color: primaryColor,
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
        itemCount: _repositories.length,
        itemBuilder: (_, index) {
          final hadDivider = index != _repositories.length - 1;

          return RepositoryListItem(
            onTap: _handleRepositoryTap,
            onUnstar: _handleStarTap,
            useStarButton: true,
            repository: _repositories[index],
            hasDivider: hadDivider,
          );
        },
      ),
    );
  }

  Widget _createSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 76,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              onSubmitted: (text) => _handleSearch(),
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: primaryColor,
                    width: 1,
                  ),
                ),
                hintText: "검색어를 입력하세요.",
              ),
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 80,
            height: double.infinity,
            child: OutlinedButton(
              onPressed: _handleSearch,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: secondaryColor,
                ),
              ),
              child: const Text(
                "검색",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
