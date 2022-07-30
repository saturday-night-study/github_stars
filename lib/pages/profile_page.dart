import 'package:flutter/material.dart';
import 'package:github_stars/github/rest_client.dart';
import 'package:github_stars/models/repository.dart';
import 'package:github_stars/models/user.dart';
import 'package:github_stars/pages/signin_page.dart';
import 'package:github_stars/pages/webview_page.dart';
import 'package:github_stars/service/current_user.dart';
import 'package:github_stars/theme.dart';
import 'package:github_stars/widgets/github_appbar.dart';
import 'package:github_stars/widgets/repository_list_item.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? _user;
  List<Repository> _repositories = List.empty();
  bool get isDataLoading => _user == null;

  @override
  void initState() {
    super.initState();

    _loadDatas();
  }

  Future<void> _loadDatas() async {
    final results = await Future.wait([
      RestClient().getUser(),
      RestClient().getRepositories(),
    ]);

    final user = results[0] as User?;
    final repositories = results[1] as List<Repository>;
    if (user == null) {
      return;
    }

    setState(() {
      _user = user;
      _repositories = repositories;
    });
  }

  void _handleSignOut() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text("로그아웃 하시겠습니까?"),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.grey),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "취소",
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.redAccent),
              onPressed: () async {
                Navigator.pop(context);

                await CurrentUser().clearToken();

                _goToSignInPage();
              },
              child: const Text(
                "로그아웃",
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _goToSignInPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignInPage()),
    );
  }

  void _handleRepositoryTap(Repository repository) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewPage(url: repository.url),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final itemCount = _repositories.length + 2;

    return Scaffold(
      appBar: const GithubAppBar(),
      backgroundColor: Colors.grey.shade100,
      body: ListView.builder(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
        itemCount: itemCount,
        itemBuilder: (_, index) {
          if (index == 0) {
            return _createUseProfile();
          }

          if (index == 1) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(height: 40),
                Text(
                  "Repositories",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            );
          }

          final repoIndex = index - 2;
          final hadDivider = repoIndex != _repositories.length - 1;

          return RepositoryListItem(
            onTap: _handleRepositoryTap,
            repository: _repositories[repoIndex],
            hasDivider: hadDivider,
          );
        },
      ),
    );
  }

  Widget _createUseProfile() {
    if (isDataLoading) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        _createProfileDisplay(),
        _createBio(),
        const SizedBox(height: 16),
        _createEtcInfo(),
      ],
    );
  }

  Widget _createProfileDisplay() {
    if (isDataLoading) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 100,
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: primaryColor,
            backgroundImage: Image.network(_user!.avatarUrl).image,
          ),
          const SizedBox(width: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _user!.userName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                _user!.userID,
                style: const TextStyle(
                  fontSize: 13,
                  color: secondaryColor,
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: _handleSignOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }

  Widget _createBio() {
    if (isDataLoading) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        _user!.bio,
        style: const TextStyle(
          fontSize: 12,
          color: primaryColor,
        ),
      ),
    );
  }

  Widget _createEtcInfo() {
    if (isDataLoading) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        Row(
          children: [
            _createEtcInfoItem(
              icon: Icons.business,
              text: _user!.company,
            ),
            const SizedBox(width: 20),
            _createEtcInfoItem(
              icon: Icons.place_outlined,
              text: _user!.location,
            ),
          ],
        ),
        const SizedBox(height: 3),
        _createEtcInfoItem(
          icon: Icons.link,
          text: _user!.blogUrl,
          isEmphasis: true,
        ),
        const SizedBox(height: 3),
        _createEtcInfoItem(
          icon: Icons.email_outlined,
          text: _user!.email,
          isEmphasis: true,
        ),
        const SizedBox(height: 3),
        _createFollowInfo(),
      ],
    );
  }

  Widget _createEtcInfoItem({
    required IconData icon,
    required String text,
    bool isEmphasis = false,
  }) {
    if (isDataLoading) {
      return const SizedBox.shrink();
    }

    final color = isEmphasis ? primaryColor : secondaryColor;
    final fontWeight = isEmphasis ? FontWeight.bold : FontWeight.normal;

    return Row(
      children: [
        Icon(
          icon,
          size: 15,
          color: secondaryColor,
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(
            fontSize: 11,
            fontWeight: fontWeight,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _createFollowInfo() {
    if (isDataLoading) {
      return const SizedBox.shrink();
    }

    return Row(
      children: [
        const Icon(
          Icons.person_outline,
          size: 15,
          color: secondaryColor,
        ),
        const SizedBox(width: 5),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: _user!.followers.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const TextSpan(
                text: " followers • ",
                style: TextStyle(
                  color: secondaryColor,
                ),
              ),
              TextSpan(
                text: _user!.following.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const TextSpan(
                text: " following",
                style: TextStyle(
                  color: secondaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
