import 'package:flutter/material.dart';

class PlayerPrefsSection extends StatelessWidget {
  const PlayerPrefsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return /*BlocBuilder<PlayerProfileCubit, PlayerProfileState>(
      buildWhen: (previous, current) {
        if (previous.status != current.status) {
          return true;
        }

        return false;
      },
      builder: (context, state) {
        return switch (state.status) {
          PlayerProfileStatus.error => SizedBox.shrink(),
          PlayerProfileStatus.loading || PlayerProfileStatus.initial => SizedBox.shrink(),
          PlayerProfileStatus.success => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text('${state.profile.bestArcadeScore}'),
            ),
          ),
        };
      },
    );*/ Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(color: colorScheme.primary, borderRadius: BorderRadius.all(Radius.circular(32.0))),
    );
  }
}
