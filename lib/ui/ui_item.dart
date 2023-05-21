import 'package:flutter/material.dart';
import 'package:game_2048/app_colors.dart';

class ScoreItem extends StatelessWidget {
  const ScoreItem({Key? key, required this.title, required this.value})
      : super(key: key);

  final String title;
  final int value;

  @override
  Widget build(BuildContext context) {
    return UiItem(
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.titleTextColor,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value.toString(),
            style: const TextStyle(
              color: AppColors.valueTextColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class NewGameButton extends StatelessWidget {
  const NewGameButton({
    Key? key,
    required this.onClick,
  }) : super(key: key);

  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: const UiItem(
        background: AppColors.darkBackground,
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Text(
            'New Game',
            style: TextStyle(
              color: AppColors.valueTextColor,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}


class RunAiButton extends StatelessWidget {
  const RunAiButton({
    Key? key,
    required this.onClick,
  }) : super(key: key);

  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: const UiItem(
        background: AppColors.darkBackground,
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Text(
            'Run AI',
            style: TextStyle(
              color: AppColors.valueTextColor,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class TryAgainButton extends StatelessWidget {
  const TryAgainButton({
    Key? key,
    required this.onClick,
  }) : super(key: key);

  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: const UiItem(
        background: AppColors.darkBackground,
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Text(
            'Try again',
            style: TextStyle(
              color: AppColors.valueTextColor,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class UiItem extends StatelessWidget {
  const UiItem({
    Key? key,
    required this.child,
    this.background = AppColors.background,
  }) : super(key: key);

  final Widget child;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: background,
      ),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: child,
      ),
    );
  }
}
