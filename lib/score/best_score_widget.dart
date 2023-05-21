import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_2048/score/score_bloc.dart';
import 'package:game_2048/ui/ui_item.dart';

class BestScoreWidget extends StatelessWidget {
  const BestScoreWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScoreBloc, ScoreState>(
      buildWhen: (previous, current) => previous.bestScore != current.bestScore,
      builder: (context, state) {
        return ScoreItem(
          title: 'BEST',
          value: state.bestScore,
        );
      },
    );
  }
}
