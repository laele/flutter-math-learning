import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/features/game/score/cubit/score_cubit.dart';
import 'package:flutter_math_app/core/widgets/score_badge.dart';
import 'package:flutter_math_app/features/game/score/widgets/text_score_animated.dart';

class ScoreAnimated extends StatelessWidget {
  const ScoreAnimated({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScoreCubit, ScoreState>(
      buildWhen: (previous, current) =>
          previous.currentScore != current.currentScore,
      builder: (context, state) {
        return BounceInDown(
          child: ScoreBadge(
            widthSize: 80,
            heightSize: 80,
            text: state.currentScore.toString(),
          ),
        );
      },
    );
  }
}
