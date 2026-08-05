import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/core/di/init_dependencies.dart';
import 'package:flutter_math_app/core/theme/app_gradients.dart';
import 'package:flutter_math_app/features/character/presentation/character_rive.dart';
import 'package:flutter_math_app/features/character/presentation/cubit/character_cubit.dart';
import 'package:flutter_math_app/features/player_prefs/domain/enums/player_profile_status.dart';
import 'package:flutter_math_app/features/player_prefs/presentation/cubit/player_profile_cubit.dart';
import 'package:flutter_math_app/features/player_prefs/presentation/widgets/player_prefs_section.dart';
import 'package:flutter_math_app/features/scenes/presentation/menu/widgets/menu_canvas.dart';
import 'package:flutter_math_app/features/scenes/presentation/menu/widgets/menu_fab.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<CharacterCubit>(),
        ),
      ],
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: AppGradients.background,
                    ),
                  ),
                ),

                CharacterRive(),
              ],
            ),
            MenuCanvas(),
          ],
        ),
        floatingActionButton: MenuFloatingActionButtons(),
      ),
    );
  }
}
