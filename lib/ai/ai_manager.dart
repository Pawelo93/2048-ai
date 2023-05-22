import 'package:game_2048/ai/mini_max/mini_max.dart';
import 'package:game_2048/board/board.dart';
import 'package:game_2048/game/game_bloc.dart';

class AiManager {
  final MiniMax _miniMax = MiniMax();

  Future<MoveDirection> findBestMove(Board board) async {
    final result = await _miniMax.minimax(board, 4, MaximizingPlayer.player, 0);
    return result.direction;
  }
}