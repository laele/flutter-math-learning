import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/core/widgets/app_main_title_text.dart';
import 'package:flutter_math_app/core/widgets/custom_icon.dart';
import 'package:flutter_math_app/features/player_prefs/presentation/widgets/player_prefs_card.dart';
import 'package:flutter_math_app/features/scenes/presentation/shared/widgets/banner_ad_widget.dart';
import 'package:flutter_math_app/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:flutter_math_app/features/settings/presentation/widgets/language_sheet.dart';

class MenuCanvas extends StatelessWidget {
  const MenuCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Align(
              alignment: AlignmentGeometry.topCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //BannerAdWidget(),
                  SizedBox(height: 8),
                  // Profile Header
                  PlayerPrefsCard(),

                  // App Name Text
                  AppMainTitleText(),
                ],
              ),
            ),

            Align(
              alignment: AlignmentGeometry.bottomLeft,
              child: Row(
                children: [
                  FilledButton.icon(
                    onPressed: () {
                      LanguageSheet.show(context);
                    },
                    label: Text(
                      context
                          .read<SettingsCubit>()
                          .state
                          .locale!
                          .languageCode, // current lang string,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                    ),
                    icon: CustomIcon(
                      assetRoute: 'lib/core/assets/images/lang_icon.png',
                      useColor: false,
                      size: IconSize.lg,
                    ),
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
