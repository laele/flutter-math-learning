import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/core/l10n/arb/app_localizations.dart';
import 'package:flutter_math_app/core/theme/app_colors.dart';
import 'package:flutter_math_app/core/widgets/custom_icon.dart';
import 'package:flutter_math_app/core/widgets/score_badge.dart';
import 'package:flutter_math_app/features/player_prefs/presentation/cubit/player_profile_cubit.dart';
import 'package:flutter_math_app/features/scenes/presentation/practice_game/practice_game_screen.dart';
import 'package:flutter_math_app/features/scenes/presentation/tutorial/tutorial_screen.dart';
import 'package:flutter_math_app/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:flutter_math_app/features/settings/presentation/widgets/language_sheet.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuCanvas extends StatelessWidget {
  const MenuCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            // Logo
            Align(
              alignment: AlignmentGeometry.topCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AspectRatio(
                    aspectRatio: 3 / 1,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        //color: AppColors.primary,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Center(
                        child: Text(
                          'MathHop',
                          style:
                              GoogleFonts.baloo2(
                                textStyle: Theme.of(context).textTheme.displayLarge,
                              ).copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                              ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 8),

                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(
                        24.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.hello,
                                style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Align(alignment: AlignmentGeometry.centerLeft, child: EditablePlayerName()),
                              ),
                              SizedBox(width: 18),
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
                                          Row(
                                            children: [
                                              ScoreBadge(
                                                widthSize: 50,
                                                heightSize: 50,
                                                child: Text(state.profile.bestArcadeScore.toString()),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 4.0),
                                          Text(
                                            l10n.bestScore,
                                            style: Theme.of(context).textTheme!.labelMedium!.copyWith(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Wrap(
                    alignment: WrapAlignment.end,
                    //mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FilledButton(
                        onPressed: () {
                          LanguageSheet.show(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomIcon(
                              assetRoute: 'lib/core/assets/images/lang_icon.png',
                              useColor: false,
                              size: IconSize.lg,
                            ),
                            SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                context.read<SettingsCubit>().state.locale!.languageCode, // current lang string,
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8),
                      FilledButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => TutorialScreen()),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomIcon(
                              assetRoute: 'lib/core/assets/images/how_to_play_icon.png',
                              useColor: false,
                              size: IconSize.lg,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8),
                      FilledButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => PracticeGameScreen()),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomIcon(
                              assetRoute: 'lib/core/assets/images/play_icon.png',
                              useColor: false,
                            ),
                            SizedBox(width: 4.0),
                            Flexible(
                              child: Text(
                                l10n.practiceMode,
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditablePlayerName extends StatefulWidget {
  const EditablePlayerName({
    super.key,
  });

  @override
  State<EditablePlayerName> createState() => _EditablePlayerNameState();
}

class _EditablePlayerNameState extends State<EditablePlayerName> {
  bool _isEditing = false;
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerProfileCubit, PlayerProfileState>(
      buildWhen: (previous, current) => previous.profile.playerName != current.profile.playerName,
      builder: (context, state) {
        if (!_isEditing && _controller.text != state.profile.playerName) {
          _controller.text = state.profile.playerName;
        }
        return !_isEditing
            ? Badge(
                padding: EdgeInsets.all(8.0),
                backgroundColor: AppColors.onPrimaryBorder,
                label: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: CustomIcon(
                    assetRoute: 'lib/core/assets/images/edit.png',
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    setState(() => _isEditing = true);

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _focusNode.requestFocus();
                      _controller.selection = TextSelection.fromPosition(
                        TextPosition(offset: _controller.text.length),
                      );
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        state.profile.playerName,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            : Form(
                key: _formKey,
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  maxLength: 12,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
                  controller: _controller,
                  focusNode: _focusNode,
                  autofocus: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter your name';
                    }

                    if (value.trim().length < 3) {
                      return 'Minimum 3 characters';
                    }

                    return null;
                  },
                  onTapOutside: (event) {
                    setState(() {
                      _isEditing = false;
                      //_controller.text = state.profile.playerName;
                    });
                  },
                  onFieldSubmitted: (value) {
                    setState(() {
                      _isEditing = false;
                      if (_formKey.currentState!.validate()) {
                        context.read<PlayerProfileCubit>().updateName(name: value.trim());
                      }
                    });
                  },
                ),
              );
      },
    );
  }
}
