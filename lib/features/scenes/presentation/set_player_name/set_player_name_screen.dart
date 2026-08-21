import 'package:flutter/material.dart';
import 'package:flutter_math_app/core/l10n/arb/app_localizations.dart';
import 'package:flutter_math_app/core/theme/app_colors.dart';
import 'package:flutter_math_app/core/widgets/app_card.dart';
import 'package:flutter_math_app/core/widgets/custom_icon.dart';
import 'package:flutter_math_app/core/widgets/floating_math_symbols_background.dart';
import 'package:flutter_math_app/features/player_prefs/presentation/widgets/editable_player_name.dart';
import 'package:flutter_math_app/features/scenes/presentation/menu/menu_screen.dart';
import 'package:flutter_math_app/features/scenes/presentation/tutorial/tutorial_screen.dart';

class SetPlayerNameScreen extends StatefulWidget {
  const SetPlayerNameScreen({super.key});

  @override
  State<SetPlayerNameScreen> createState() => _SetPlayerNameScreenState();
}

class _SetPlayerNameScreenState extends State<SetPlayerNameScreen> {
  final _playerNameKey = GlobalKey<EditablePlayerNameState>();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.appSplashBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              FloatingMathSymbolsBackground(
                color: Colors.white,
                opacity: 0.85,
                symbolCount: 60,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    l10n.whatIsYourName,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontFamily: 'Gocake',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.4),
                          offset: const Offset(0, 2),
                          blurRadius: 8,
                        ),
                        Shadow(
                          color: Colors.black.withOpacity(0.6),
                          offset: const Offset(0, 0),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  AppCard(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Flexible(
                            child: EditablePlayerName(key: _playerNameKey),
                          ),
                          SizedBox(width: 8.0),
                          IconButton(
                            onPressed: () {
                              final isValid =
                                  _playerNameKey.currentState?.validate() ??
                                  false;

                              if (!isValid) return;
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const TutorialScreen(),
                                ),
                              );
                            },
                            icon: CustomIcon(
                              assetRoute:
                                  'lib/core/assets/images/arrow_right.png',
                            ),
                          ),
                        ],
                      ),
                    ),
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
