import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_2048/ai/ai_manager.dart';
import 'package:game_2048/ai/genetic/ui/genetic_bloc.dart';
import 'package:game_2048/ai/genetic/genetic_manager.dart';
import 'package:game_2048/app_colors.dart';
import 'package:game_2048/game/game_bloc.dart';
import 'package:game_2048/ui/board_view.dart';
import 'package:game_2048/ui/no_animation_board_view.dart';
import 'package:game_2048/ui/ui_item.dart';

class GeneticGameView extends StatefulWidget {
  GeneticGameView({Key? key}) : super(key: key);

  @override
  State<GeneticGameView> createState() => _GeneticGameViewState();
}

class _GeneticGameViewState extends State<GeneticGameView> {
  final AiManager aiManager = AiManager();

  final GeneticManager geneticManager = GeneticManager();

  bool stepper = false;
  bool lock = false;
  int score = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GeneticBloc, GeneticState>(
      listener: (context, state) {
        context.read<GameBloc>().startGame();
      },
      builder: (context, geneticState) {
        final currentWeights = geneticState.currentWeights;
        return BlocConsumer<GameBloc, GameState>(
          listener: (context, state) async {
            print('STATE $state');

            if (state is PlayingGameState) {
              if (state.addToScore > 0) {
                score += state.addToScore;
              }
              if (state.movingActor == MovingActor.system) {
                context.read<GameBloc>().systemMove();
              }
              if (state.movingActor == MovingActor.player) {
                if (currentWeights != null) {
                  moveAi(context, currentWeights);
                }
              }
            } else if (state is WaitingGameState) {
              if (state.waitingGameType == WaitingGameType.beforeStart) {
                context.read<GeneticBloc>().terminate();
              }
              if (state.waitingGameType == WaitingGameType.gameOver) {
                context.read<GeneticBloc>().end(score);
                score = 0;
                // context.read<ScoreBloc>().updateBestScore();
              }
            }
          },
          builder: (context, state) {
            if (state is HasBoardState) {
              return Column(
                children: [
                  Column(
                    children: [
                      NoAnimationBoardView(
                        positionedTiles: state.board.toPositionedTiles(),
                        boardWidth: 160,
                      )
                    ],
                  ),
                ],
              );
            }

            return Text('Unknown state ${state}');
          },
        );
      },
    );
  }

  void moveAi(BuildContext context, ScoreWeights scoreWeights) async {
    if (lock) {
      return;
    }

    final currentState = context.read<GameBloc>().state;

    if (currentState is PlayingGameState) {
      // TODO load best weight
      final aiMove = await aiManager.findBestMove(currentState.board, scoreWeights);
      print('AI MOVE ${aiMove}');
      final newCurrentState = context.read<GameBloc>().state;
      if (aiMove == null) {
        print('CANNOT MOVE !!!!');
      }
      if (aiMove != null && newCurrentState is PlayingGameState) {
        context.read<GameBloc>().move(aiMove);
        context.read<GameBloc>().animationEnd();
      }

      if (stepper) {
        lock = true;
      }
    }
  }
}