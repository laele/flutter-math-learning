import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/core/di/init_dependencies.dart';
import 'package:flutter_math_app/core/theme/app_gradients.dart';
import 'package:flutter_math_app/features/character/presentation/character_rive.dart';
import 'package:flutter_math_app/features/character/presentation/cubit/character_cubit.dart';
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
            /*Padding(
              padding: const EdgeInsets.all(16.0),
              child: MenuCanvas(),
            ),*/
          ],
        ),
        floatingActionButton: MenuFloatingActionButtons(),
      ),
    );
  }
}
