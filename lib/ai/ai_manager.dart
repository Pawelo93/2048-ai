import 'dart:isolate';

import 'package:game_2048/ai/genetic/genetic_manager.dart';
import 'package:game_2048/ai/mini_max/mini_max.dart';
import 'package:game_2048/board/board.dart';
import 'package:game_2048/game/game_bloc.dart';

// TODO
/*
1 . DB iser [v]
2. beta pruning
3. more weights
4. mutations
 */
class AiManager {
  final MiniMax _miniMax = MiniMax();

  int step = 0;

  Future<MoveDirection?> findBestMove(Board board, ScoreWeights weights) async {
    _miniMax.setupWeights(weights);

    bool blocking = true;
    MiniMaxResult result;
    if (blocking) {
      if (step > 0) {
        await Future.delayed(Duration(milliseconds: 5));
        step = 0;
      }
      result = await _miniMax.minimax(
        board,
        4,
        MaximizingPlayer.player,
        0,
      );
      step++;
    } else {
      result = await Isolate.run(() async {
        final start = DateTime.now().millisecondsSinceEpoch;
        final result =
            await _miniMax.minimax(board, 2, MaximizingPlayer.player, 0);
        final time = DateTime.now().millisecondsSinceEpoch - start;
        print('TIME : $time ms');
        return result;
      });
    }

    return result.direction;
  }
}
