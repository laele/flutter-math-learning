import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/core/theme/app_colors.dart';
import 'package:flutter_math_app/features/game/score/widgets/score_badge.dart';
import 'package:flutter_math_app/features/player_prefs/presentation/cubit/player_profile_cubit.dart';

class MenuCanvas extends StatelessWidget {
  const MenuCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            // Logo
            Align(
              alignment: AlignmentGeometry.topCenter,
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 20 / 9,
                    child: Container(
                      width: double.infinity,
                      //height: 100,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),

                  SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Player',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      BlocBuilder<PlayerProfileCubit, PlayerProfileState>(
                        buildWhen: (previous, current) {
                          if (previous.newRecordEvent != current.newRecordEvent) {
                            return true;
                          }
                          return false;
                        },
                        builder: (context, state) {
                          return Container(
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ScoreBadge(
                                    widthSize: 50,
                                    heightSize: 50,
                                    child: Text(state.profile.bestArcadeScore.toString()),
                                  ),
                                  Text(
                                    'Best Score!',
                                    style: Theme.of(context).textTheme!.titleMedium!.copyWith(color: Colors.red, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  FilledButton(onPressed: () {}, child: Text('Practice Mode')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
