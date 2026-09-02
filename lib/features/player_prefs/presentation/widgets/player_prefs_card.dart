import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/core/theme/app_colors.dart';
import 'package:flutter_math_app/core/widgets/app_card.dart';
import 'package:flutter_math_app/core/widgets/score_badge.dart';
import 'package:flutter_math_app/features/player_prefs/presentation/cubit/player_profile_cubit.dart';
import 'package:flutter_math_app/features/player_prefs/presentation/widgets/editable_player_name.dart';

class PlayerPrefsCard extends StatelessWidget {
  const PlayerPrefsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 650),
      child: AppCard(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.onPrimaryBorder,
                    ),
                    child: CircleAvatar(
                      radius: 28,
                      backgroundImage: AssetImage(
                        'lib/core/assets/images/avatar_1.png',
                      ),
                    ),
                  ),
                  SizedBox(width: 12.0),
                  Flexible(child: EditablePlayerName()),
                  SizedBox(width: 12.0),
                  Column(
                    children: [
                      ScoreBadge(
                        widthSize: 50,
                        heightSize: 50,
                        showBackground: true,
                        text: context
                            .read<PlayerProfileCubit>()
                            .state
                            .profile
                            .bestArcadeScore
                            .toString(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
