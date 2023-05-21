import 'package:shared_preferences/shared_preferences.dart';

class BestScoreRepository {
  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  Future<int> get() async {
    return (await _prefs).getInt('best_score') ?? 0;
  }

  Future<void> set(int bestScore) async {
    (await _prefs).setInt('best_score', bestScore);
  }
}