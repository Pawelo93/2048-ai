import 'dart:collection';

import 'package:game_2048/board/multi_tile.dart';
import 'package:game_2048/board/tile.dart';
import 'package:game_2048/two_dimens_array.dart';

class ListToTwoDimensArrayMapper {
  static TwoDimensArray map(List<List<Tile>> tiles) {
    final twoDimensArray = TwoDimensArray(HashMap());

    // if tiles length is 16
    for(var y = 0; y < 4; y++) {
      for(var x = 0; x < 4; x++) {
        final multipleTilesList = tiles[y * 4 + x];
        if (multipleTilesList.isNotEmpty) {
          twoDimensArray.put(x, y, MultiTile(multipleTilesList));
        }
      }
    }
    // what if tiles are only two?

    return twoDimensArray;
  }
}