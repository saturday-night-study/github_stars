import 'package:flutter/material.dart';
import 'package:github_stars/models/repository.dart';
import 'package:github_stars/theme.dart';

class RepositoryListItem extends StatelessWidget {
  const RepositoryListItem({
    Key? key,
    required this.onTap,
    required this.repository,
    this.hasDivider = true,
  }) : super(key: key);

  final Function(Repository) onTap;
  final Repository repository;
  final bool hasDivider;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(repository),
      behavior: HitTestBehavior.translucent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Text(
            repository.name,
            style: const TextStyle(
              color: primaryColor,
              fontSize: 15,
              height: 20 / 15,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            repository.description,
            style: const TextStyle(
              color: secondaryColor,
              fontSize: 13,
              height: 18 / 13,
            ),
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              _createInfoItem(
                icon: Icons.star_outline,
                text: repository.stars.toString(),
              ),
              const SizedBox(width: 20),
              _createInfoItem(
                icon: Icons.fork_right,
                text: repository.forks.toString(),
              ),
              const SizedBox(width: 20),
              Visibility(
                visible: repository.language.isNotEmpty,
                child: _createInfoItem(
                  icon: Icons.code,
                  text: repository.language,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Visibility(
            visible: hasDivider,
            child: const Divider(height: 0.5, thickness: 0.5),
          ),
        ],
      ),
    );
  }

  Widget _createInfoItem({
    required IconData icon,
    required String text,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: primaryColor,
        ),
        const SizedBox(width: 3),
        Text(
          text,
          style: const TextStyle(
            fontSize: 13,
            color: primaryColor,
          ),
        ),
      ],
    );
  }
}
