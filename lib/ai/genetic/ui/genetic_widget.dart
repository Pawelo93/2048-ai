import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_2048/ai/genetic/ui/genetic_bloc.dart';
import 'package:game_2048/ai/genetic/ui/genetic_game_view.dart';
import 'package:game_2048/game/game_bloc.dart';
import 'package:game_2048/score/score_bloc.dart';
import 'package:game_2048/ui/ui_item.dart';

class GeneticWidget extends StatelessWidget {
  const GeneticWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ScoreBloc()),
        BlocProvider(create: (_) => GeneticBloc()..start()),
        BlocProvider(create: (_) => GameBloc()),
      ],
      child: Column(
        children: [
          Row(
            children: [
              GeneticGameView(),
            ],
          ),
          Builder(
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: RunAiButton(
                  onClick: () {
                    print('START');
                    final bloc = context.read<GameBloc>();
                    if(bloc.state is PlayingGameState) {
                      bloc.stop();
                    } else {
                      bloc.startGame();
                      context.read<GeneticBloc>().start();
                    }
                  },
                ),
              );
            }
          ),
        ],
      ),
    );
  }
}
