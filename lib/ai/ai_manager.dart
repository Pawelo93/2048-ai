import 'dart:isolate';

import 'package:game_2048/ai/mini_max/mini_max.dart';
import 'package:game_2048/board/board.dart';
import 'package:game_2048/game/game_bloc.dart';

class AiManager {
  final MiniMax _miniMax = MiniMax();

  Future<MoveDirection> findBestMove(Board board) async {
    bool blocking = false;
    MiniMaxResult result;
    if (blocking) {
      result = await _miniMax.minimax(
          board, 2, MaximizingPlayer.player, 0);
    } else {
      result = await Isolate.run(() {
        return _miniMax.minimax(board, 2, MaximizingPlayer.player, 0);
      });
    }

    return result.direction;
  }
}