import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/core/di/init_dependencies.dart';
import 'package:flutter_math_app/core/theme/app_gradients.dart';
import 'package:flutter_math_app/features/character/presentation/character_rive.dart';
import 'package:flutter_math_app/features/character/presentation/cubit/character_cubit.dart';
import 'package:flutter_math_app/features/dialog_message/cubit/dialog_message_cubit.dart';
import 'package:flutter_math_app/features/dialog_message/presentation/dialog_message_text.dart';
import 'package:flutter_math_app/features/game/presentation/game_cubit/game_cubit.dart';
import 'package:flutter_math_app/features/scenes/presentation/game/widgets/game_fab.dart';
import 'package:flutter_math_app/features/scenes/presentation/game/widgets/scribble_canvas.dart';
import 'package:flutter_math_app/features/scenes/presentation/game/widgets/pencil_sign.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<GameCubit>()),
        BlocProvider(create: (_) => sl<CharacterCubit>()),
        BlocProvider(create: (_) => sl<DialogMessageCubit>()),
      ],
      child: GameView(),
    );
  }
}

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // call after 1st Frame
      context.read<GameCubit>().generateNextLevel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameCubit, GameState>(
      listenWhen: (previous, current) {
        if ((previous.gameDialogMessage != current.gameDialogMessage) && current.gameDialogMessage != null) {
          return true;
        }
        return false;
      },
      listener: (context, state) {
        context.read<DialogMessageCubit>().showMessage(message: state.gameDialogMessage!.message, upperMessage: state.gameDialogMessage!.upperMessage);
      },
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: AppGradients.background,
                        ),
                      ),
                      Align(alignment: AlignmentGeometry.center, child: PencilSign()),
                      Align(alignment: AlignmentGeometry.bottomCenter, child: DialogMessageText()),
                    ],
                  ),
                ),

                CharacterRive(),
              ],
            ),
            ScribbleCanvas(),
          ],
        ),

        floatingActionButton: GameFloatingActionButtons(),
      ),
    );
  }
}
