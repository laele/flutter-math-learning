import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/core/l10n/arb/app_localizations.dart';
import 'package:flutter_math_app/core/widgets/app_main_title_text.dart';
import 'package:flutter_math_app/core/widgets/custom_icon.dart';
import 'package:flutter_math_app/features/player_prefs/presentation/widgets/player_prefs_card.dart';
import 'package:flutter_math_app/features/scenes/presentation/shared/widgets/banner_ad_widget.dart';
import 'package:flutter_math_app/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:flutter_math_app/features/settings/presentation/widgets/language_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

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
            Align(
              alignment: AlignmentGeometry.topCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Banner Ad
                  BannerAdWidget(),

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
              child: FilledButton.icon(
                onPressed: () {
                  LanguageSheet.show(context);
                },
                label: Text(
                  context.read<SettingsCubit>().state.locale!.languageCode, // current lang string,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                ),
                icon: CustomIcon(
                  assetRoute: 'lib/core/assets/images/lang_icon.png',
                  useColor: false,
                  size: IconSize.lg,
                ),
              ),
            ),

            Align(
              alignment: AlignmentGeometry.bottomRight,
              child: FilledButton.icon(
                onPressed: () {
                  showAboutDialog(
                    context: context,
                    applicationName: 'MathScrib',
                    applicationVersion: '1.0.0',
                    applicationIcon: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(15.0),
                      child: Image.asset(
                        'assets/images/app_icon/app_icon.png',
                        width: 48,
                        height: 48,
                      ),
                    ),
                    applicationLegalese: '© 2026 Luis Soriano',
                    children: [
                      SizedBox(height: 16),
                      Divider(),
                      Text(l10n.riveAssetCredits),
                      const SizedBox(height: 8),

                      InkWell(
                        onTap: () async {
                          final url = Uri.parse('https://rive.app/marketplace/22403-41949-greg-the-frog/');
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url, mode: LaunchMode.externalApplication);
                          }
                        },
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.open_in_new, color: Colors.blue),
                            SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                'https://rive.app/marketplace/22403-41949-greg-the-frog/',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                label: CustomIcon(
                  assetRoute: 'lib/core/assets/images/info.png',
                  useColor: false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
