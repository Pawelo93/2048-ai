import 'package:flutter_test/flutter_test.dart';
import 'package:game_2048/board.dart';
import 'package:game_2048/board_transformer.dart';
import 'package:game_2048/model/position.dart';

void main() {
  final BoardTransformer transformer = BoardTransformer();

  group('move 1', () {
    test('should go right when no obstacles 1', () {
      final startBoard = Board.fromList(
        [
          [0, 0, 0, 0],
          [0, 0, 2, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
        ],
      );

      final endBoard = Board.fromList(
        [
          [0, 0, 0, 0],
          [2, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
        ],
      );

      final result = transformer.transform(startBoard);
      expect(result.newBoard, endBoard);
      expect(result.transforms, [Transform(Position(2, 1), Position(0, 1), 2)]);
    });

    test('should go right when no obstacles 2', () {
      final startBoard = Board.fromList(
        [
          [0, 0, 0, 0],
          [2, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
        ],
      );

      final endBoard = Board.fromList(
        [
          [0, 0, 0, 0],
          [2, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
        ],
      );

      final result = transformer.transform(startBoard);
      expect(result.newBoard, endBoard);
      expect(result.transforms, []);
    });
  });

  group('move 2', () {
    test('should merge when obstacle', () {
      final startBoard = Board.fromList(
        [
          [0, 0, 0, 0],
          [0, 2, 0, 2],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
        ],
      );

      final endBoard = Board.fromList(
        [
          [0, 0, 0, 0],
          [4, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
        ],
      );

      final result = transformer.transform(startBoard);
      expect(result.newBoard, endBoard);
      expect(result.transforms, [
        Transform(Position(1, 1), Position(0, 1), 2),
        Transform(Position(3, 1), Position(0, 1), 2),
      ]);
    });

    test('should move 2 (1)', () {
      final startBoard = Board.fromList(
        [
          [0, 0, 0, 0],
          [0, 2, 4, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
        ],
      );

      final endBoard = Board.fromList(
        [
          [0, 0, 0, 0],
          [2, 4, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
        ],
      );

      final result = transformer.transform(startBoard);
      expect(result.newBoard, endBoard);
    });

    test('should move 2 (2)', () {
      final startBoard = Board.fromList(
        [
          [0, 0, 0, 0],
          [2, 0, 0, 2],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
        ],
      );

      final endBoard = Board.fromList(
        [
          [0, 0, 0, 0],
          [4, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
        ],
      );

      final result = transformer.transform(startBoard);
      expect(result.newBoard, endBoard);
    });

    test('should move 2 (3)', () {
      final startBoard = Board.fromList(
        [
          [0, 0, 0, 0],
          [2, 0, 0, 4],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
        ],
      );

      final endBoard = Board.fromList(
        [
          [0, 0, 0, 0],
          [2, 4, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
        ],
      );

      final result = transformer.transform(startBoard);
      expect(result.newBoard, endBoard);
    });
  });

  group('move 3', () {
    test('should merge 3 (1)', () {
      final startBoard = Board.fromList(
        [
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [2, 4, 2, 0],
          [0, 0, 0, 0],
        ],
      );

      final endBoard = Board.fromList(
        [
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [2, 4, 2, 0],
          [0, 0, 0, 0],
        ],
      );

      final result = transformer.transform(startBoard);
      expect(result.newBoard, endBoard);
    });

    test('should merge 3 (2)', () {
      final startBoard = Board.fromList(
        [
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 2, 4, 2],
          [0, 0, 0, 0],
        ],
      );

      final endBoard = Board.fromList(
        [
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [2, 4, 2, 0],
          [0, 0, 0, 0],
        ],
      );

      final result = transformer.transform(startBoard);
      expect(result.newBoard, endBoard);
    });

    test('should merge 3 (3)', () {
      final startBoard = Board.fromList(
        [
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 2, 2, 4],
          [0, 0, 0, 0],
        ],
      );

      final endBoard = Board.fromList(
        [
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [4, 4, 0, 0],
          [0, 0, 0, 0],
        ],
      );

      final result = transformer.transform(startBoard);
      expect(result.newBoard, endBoard);
    });

    test('should merge 3 (4)', () {
      final startBoard = Board.fromList(
        [
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 2, 2, 4],
          [0, 0, 0, 0],
        ],
      );

      final endBoard = Board.fromList(
        [
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [4, 4, 0, 0],
          [0, 0, 0, 0],
        ],
      );

      final result = transformer.transform(startBoard);
      expect(result.newBoard, endBoard);
    });
  });

  group('move 4', () {
    test('should merge 4 (1)', () {
      final startBoard = Board.fromList(
        [
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [2, 2, 2, 2],
          [0, 0, 0, 0],
        ],
      );

      final endBoard = Board.fromList(
        [
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [4, 4, 0, 0],
          [0, 0, 0, 0],
        ],
      );

      final result = transformer.transform(startBoard);
      expect(result.newBoard, endBoard);
    });

    test('should merge 4 (2)', () {
      final startBoard = Board.fromList(
        [
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [2, 4, 2, 2],
          [0, 0, 0, 0],
        ],
      );

      final endBoard = Board.fromList(
        [
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [2, 4, 4, 0],
          [0, 0, 0, 0],
        ],
      );

      final result = transformer.transform(startBoard);
      expect(result.newBoard, endBoard);
    });

    test('should merge 4 (3)', () {
      final startBoard = Board.fromList(
        [
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [4, 2, 2, 2],
          [0, 0, 0, 0],
        ],
      );

      final endBoard = Board.fromList(
        [
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [4, 4, 2, 0],
          [0, 0, 0, 0],
        ],
      );

      final result = transformer.transform(startBoard);
      expect(result.newBoard, endBoard);
    });

    test('should merge 4 (4)', () {
      final startBoard = Board.fromList(
        [
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [2, 2, 4, 2],
          [0, 0, 0, 0],
        ],
      );

      final endBoard = Board.fromList(
        [
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [4, 4, 2, 0],
          [0, 0, 0, 0],
        ],
      );

      final result = transformer.transform(startBoard);
      expect(result.newBoard, endBoard);
    });
  });
}
