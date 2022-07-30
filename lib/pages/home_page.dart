import 'package:flutter/material.dart';
import 'package:github_stars/github/rest_client.dart';
import 'package:github_stars/models/token.dart';
import 'package:github_stars/pages/profile_page.dart';
import 'package:github_stars/pages/search_page.dart';
import 'package:github_stars/pages/signin_page.dart';
import 'package:github_stars/pages/stars_page.dart';
import 'package:github_stars/service/current_user.dart';
import 'package:github_stars/theme.dart';
import 'package:github_stars/widgets/github_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void _handleTabBarDidSelect(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: _createTabBar(),
        body: IndexedStack(
          index: _currentIndex,
          children: const [
            StarsPage(),
            SearchPage(),
            ProfilePage(),
          ],
        ),
      ),
    );
  }

  Widget _createTabBar() {
    return BottomNavigationBar(
      onTap: _handleTabBarDidSelect,
      currentIndex: _currentIndex,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.blueGrey,
      backgroundColor: primaryColor,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.stars),
          label: "Stars",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.saved_search),
          label: "Search",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: "Profile",
        ),
      ],
    );
  }
}
