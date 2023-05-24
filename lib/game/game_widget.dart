import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_2048/ai/ai_manager.dart';
import 'package:game_2048/ai/genetic/genetic_manager.dart';
import 'package:game_2048/app_colors.dart';
import 'package:game_2048/board/board.dart';
import 'package:game_2048/game/game_bloc.dart';
import 'package:game_2048/game_mode.dart';
import 'package:game_2048/main.dart';
import 'package:game_2048/score/score_bloc.dart';
import 'package:game_2048/ui/board_view.dart';
import 'package:game_2048/ui/no_animation_board_view.dart';
import 'package:game_2048/ui/ui_item.dart';

class GameWidget extends StatelessWidget {
  const GameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: FocusNode()..requestFocus(),
      onKeyEvent: (event) {
        if (gameMode == GameMode.ai) {
          return;
        }
        if (event is KeyUpEvent) {
          return;
        }
        if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
          context.read<GameBloc>().move(MoveDirection.left);
        } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
          context.read<GameBloc>().move(MoveDirection.right);
        } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
          context.read<GameBloc>().move(MoveDirection.up);
        } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
          context.read<GameBloc>().move(MoveDirection.down);
        }
      },
      child: GameView(),
    );
  }
}

class GameView extends StatelessWidget {
  GameView({Key? key}) : super(key: key);

  final AiManager aiManager = AiManager();

  bool stepper = false;
  bool lock = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameBloc, GameState>(
      listener: (context, state) async {
        if (state is PlayingGameState) {
          if (state.addToScore > 0) {
            context.read<ScoreBloc>().addScore(state.addToScore);
          }
          if (state.movingActor == MovingActor.system) {
            context.read<GameBloc>().systemMove();
          }
          if (gameMode == GameMode.ai &&
              state.movingActor == MovingActor.player) {
            moveAi(context);
          }
        } else if (state is WaitingGameState) {
          if (state.waitingGameType == WaitingGameType.gameOver) {
            context.read<ScoreBloc>().updateBestScore();
          }
        }
      },
      builder: (context, state) {
        if (state is WaitingGameState) {
          return Stack(
            children: [
              Opacity(
                opacity: 0.3,
                child: BoardWidget(
                  positionedTiles: state.board.toPositionedTiles(),
                ),
              ),
              Positioned.fill(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Text(
                        'Game over!',
                        style: TextStyle(
                          color: AppColors.tileTextColor,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TryAgainButton(
                        onClick: () {
                          context.read<ScoreBloc>().clear();
                          context.read<GameBloc>().startGame();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else if (state is PlayingGameState) {
          return Column(
            children: [
              GamePlayingStateView(
                board: state.board,
              ),
              if (gameMode == GameMode.ai)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RunAiButton(
                    onClick: () {
                      if (stepper) {
                        lock = false;
                      }
                      moveAi(context);
                    },
                  ),
                ),
            ],
          );
        }

        return Text('Unknown state ${state}');
      },
    );
  }

  void moveAi(BuildContext context) async {
    if (lock) {
      return;
    }

    final currentState = context.read<GameBloc>().state;

    if (currentState is PlayingGameState) {
      // TODO FIX WEIGHT
      final aiMove = await aiManager.findBestMove(
        currentState.board,
        const ScoreWeights(
          newPoints: Weight(0.18),
          merging: Weight(0.47),
          emptyTiles: Weight(0.30),
          clustering: Weight(0.19),
        ),
      );
      if (aiMove != null) {
        context.read<GameBloc>().move(aiMove);
        context.read<GameBloc>().animationEnd();
      }

      if (stepper) {
        lock = true;
      }
    }
  }
}

class GamePlayingStateView extends StatelessWidget {
  const GamePlayingStateView({
    Key? key,
    required this.board,
  }) : super(key: key);

  final Board board;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NoAnimationBoardWidget(
          positionedTiles: board.toPositionedTiles(),
        )
      ],
    );
  }
}
