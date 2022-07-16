import 'package:flutter/material.dart';

class GithubAppBar extends StatelessWidget with PreferredSizeWidget {
  const GithubAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "assets/images/github-icon.png",
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 8),
          const Text("GitHub Stars"),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
