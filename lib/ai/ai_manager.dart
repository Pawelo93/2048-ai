import 'dart:isolate';

import 'package:game_2048/ai/alpha_beta/alpha_beta.dart';
import 'package:game_2048/ai/genetic/genetic_manager.dart';
import 'package:game_2048/ai/maximizing_player.dart';
import 'package:game_2048/ai/mini_max/mini_max.dart';
import 'package:game_2048/board/board.dart';
import 'package:game_2048/game/game_bloc.dart';

// TODO
/*
1 . DB iser [v]
2. beta pruning [v]
3. mutations
4. more weights
 */
class AiManager {
  final MiniMax _miniMax = MiniMax();
  final AlphaBeta _alphaBeta = AlphaBeta();

  int step = 0;

  Future<MoveDirection?> findBestMove(Board board, ScoreWeights weights) async {
    _miniMax.setupWeights(weights);
    _alphaBeta.setupWeights(weights);

    bool blocking = true;
    AlphaBetaResult result;
    if (blocking) {
      if (step > 0) {
        await Future.delayed(Duration(milliseconds: 5));
        step = 0;
      }
      final start = DateTime.now().millisecondsSinceEpoch;
      result = await _alphaBeta.alphaBeta(
        board,
        5,
        MaximizingPlayer.player,
        0,
        -double.infinity,
        double.infinity
      );

      final time = DateTime.now().millisecondsSinceEpoch - start;
      // print('TIME : $time ms');
      step++;
    } else {
      // result = await Isolate.run(() async {
      //   final start = DateTime.now().millisecondsSinceEpoch;
      //   final result =
      //       await _miniMax.minimax(board, 2, MaximizingPlayer.player, 0);
      //   final time = DateTime.now().millisecondsSinceEpoch - start;
      //   print('TIME : $time ms');
      //   return result;
      // });
    }

    return result.direction;
  }
}
