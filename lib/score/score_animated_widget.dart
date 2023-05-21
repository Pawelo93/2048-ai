import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_2048/app_colors.dart';
import 'package:game_2048/score/score_bloc.dart';
import 'package:game_2048/ui/ui_item.dart';

class ScoreAnimatedWidget extends StatefulWidget {
  const ScoreAnimatedWidget({Key? key}) : super(key: key);

  @override
  State<ScoreAnimatedWidget> createState() => _ScoreAnimatedWidgetState();
}

class _ScoreAnimatedWidgetState extends State<ScoreAnimatedWidget>
    with TickerProviderStateMixin {
  final Map<int, AnimationController?> _controllers = {};

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ScoreBloc, ScoreState>(
      listener: (context, state) {
        if (state.addedValue == 0) {
          return;
        }

        int? emptyIndex;
        int counter = 0;
        while (emptyIndex == null) {
          if (_controllers[counter] == null) {
            emptyIndex = counter;
          }
          counter++;
        }
        _controllers[emptyIndex] = AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 400),
        )..addStatusListener(
            (status) {
              if (status == AnimationStatus.completed) {
                if (emptyIndex != null) {
                  _controllers[emptyIndex] = null;
                  setState(() {});
                }
              }
            },
          );

        _controllers[emptyIndex]?.forward();
      },
      builder: (context, state) => Stack(
        children: [
          ScoreItem(
            title: 'SCORE',
            value: state.score,
          ),
          ..._controllers.values.map((animation) {
            if (animation != null) {
              return AnimatedBuilder(
                animation: animation,
                builder: (_, __) {
                  return Positioned(
                    top: 27 - animation.value * 30,
                    left: 12,
                    child: Opacity(
                      opacity: 1 - animation.value / 1.5,
                      child: Text(
                        '+${state.addedValue}',
                        style: const TextStyle(
                          color: AppColors.color4096,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
        ],
      ),
    );
  }
}
