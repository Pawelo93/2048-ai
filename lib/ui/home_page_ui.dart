import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_2048/app_colors.dart';
import 'package:game_2048/game/game_bloc.dart';
import 'package:game_2048/game/game_widget.dart';
import 'package:game_2048/score/best_score_widget.dart';
import 'package:game_2048/score/score_animated_widget.dart';
import 'package:game_2048/score/score_bloc.dart';
import 'package:game_2048/ui/ui_item.dart';

class HomePageUi extends StatelessWidget {
  const HomePageUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GameBloc()..startGame()),
        BlocProvider(create: (_) => ScoreBloc()..load()),
      ],
      child: LayoutBuilder(
        builder: (context, boxConstraints) {
          return SizedBox(
            width: boxConstraints.maxWidth / 2,
            child: Column(
              children: [
                const SizedBox(height: 24),
                BlocBuilder<GameBloc, GameState>(
                  builder: (context, state) => const Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '2048',
                        style: TextStyle(
                          color: AppColors.tileTextColor,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          ScoreAnimatedWidget(),
                          SizedBox(width: 8),
                          BestScoreWidget(),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const GameStatusWidget(),
                    NewGameButton(
                      onClick: () {
                        context.read<ScoreBloc>().clear();
                        context.read<GameBloc>().startGame();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const GameWidget(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class GameStatusWidget extends StatelessWidget {
  const GameStatusWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'MODE: normal game',
      style: TextStyle(
        color: AppColors.tileTextColor,
        fontSize: 13,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
