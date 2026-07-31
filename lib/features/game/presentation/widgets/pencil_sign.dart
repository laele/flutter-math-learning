import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/features/game/domain/enums/game_phase.dart';
import 'package:flutter_math_app/features/game/presentation/game_cubit/game_cubit.dart';

class PencilSign extends StatelessWidget {
  const PencilSign({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      buildWhen: (previous, current) {
        if ((previous.gamePhaseEvent != current.gamePhaseEvent) && current.gamePhaseEvent != null) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        return (state.gamePhaseEvent?.gamePhase == GamePhase.newQuestion || state.gamePhaseEvent?.gamePhase == GamePhase.repeatQuestion)
            ? _PencilSignAnimated()
            : SizedBox.shrink();
      },
    );
  }
}

class _PencilSignAnimated extends StatefulWidget {
  const _PencilSignAnimated({super.key});

  @override
  State<_PencilSignAnimated> createState() => _PencilSignAnimatedState();
}

class _PencilSignAnimatedState extends State<_PencilSignAnimated> {
  double _opacity = 1;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(milliseconds: 20),
      () {
        if (!mounted) return;
        setState(() {
          _opacity = 0.25;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BounceInDown(
      from: 20,
      duration: Duration(milliseconds: 500),
      child: AnimatedOpacity(
        duration: Duration(seconds: 1),
        opacity: _opacity,
        child: Container(
          width: 160,
          height: 160,
          child: Image.asset(
            'lib/core/assets/images/pencil.png',
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
