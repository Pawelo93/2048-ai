enum GameState {
  initial,
  playerMove,
  systemMove,
  gameWon,
  gameLose,
}

class GameController {
  GameState currentGameState = GameState.initial;


}