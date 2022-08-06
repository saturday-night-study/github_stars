import 'package:flutter/material.dart';
import 'package:github_stars/models/repository.dart';
import 'package:github_stars/theme.dart';

class RepositoryListItem extends StatelessWidget {
  const RepositoryListItem({
    Key? key,
    required this.onTap,
    this.onUnstar,
    required this.repository,
    this.useStarButton = false,
    this.hasDivider = true,
  }) : super(key: key);

  final Function(Repository) onTap;
  final Function(Repository)? onUnstar;
  final Repository repository;
  final bool useStarButton;
  final bool hasDivider;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(repository),
      behavior: HitTestBehavior.translucent,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _createRepositoryInfo(),
              _createStarButton(),
            ],
          ),
          Visibility(
            visible: hasDivider,
            child: const Divider(height: 0.5, thickness: 0.5),
          ),
        ],
      ),
    );
  }

  Widget _createRepositoryInfo() {
    return Expanded(
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
              fontSize: 12,
              height: 17 / 12,
            ),
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
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
            fontSize: 12,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _createStarButton() {
    if (!useStarButton) {
      return const SizedBox.shrink();
    }

    return Container(
      width: 40,
      height: 40,
      padding: const EdgeInsets.only(left: 6),
      child: IconButton(
        onPressed: () => onUnstar?.call(repository),
        icon: const Icon(
          Icons.star,
          size: 24,
        ),
      ),
    );
  }
}
