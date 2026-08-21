import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/features/game/presentation/game_cubit/game_cubit.dart';
import 'package:flutter_math_app/features/scenes/presentation/shared/widgets/title_phase_row.dart';
import 'package:flutter_math_app/features/tutorial/presentation/cubit/tutorial_cubit.dart';
import 'package:flutter_math_app/features/tutorial/presentation/widgets/tutorial_number_indicator_row.dart';
import 'package:flutter_math_app/features/tutorial/presentation/widgets/tutorial_progress_indicatior_bar.dart';

class TutorialTopBar extends StatelessWidget {
  const TutorialTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              Align(
                alignment: AlignmentGeometry.topCenter,
                child: Column(
                  children: [
                    TutorialNumberIndicatorRow(),
                    SizedBox(height: 8.0),
                    TutorialProgressIndicatiorBar(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
