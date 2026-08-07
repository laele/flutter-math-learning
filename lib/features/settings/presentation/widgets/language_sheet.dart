import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/core/theme/app_colors.dart';
import 'package:flutter_math_app/features/settings/domain/constants/app_languages.dart';
import 'package:flutter_math_app/features/settings/presentation/cubit/settings_cubit.dart';

class LanguageSheet extends StatelessWidget {
  const LanguageSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: AppColors.appBackground,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.vertical(
          top: Radius.circular(24.0),
        ),
      ),
      context: context,
      builder: (context) => LanguageSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Select Lanaguge', style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
              for (var item in AppLanguages.languages.entries.toList())
                ListTile(
                  title: Text(item.value),
                  subtitle: Text(item.key),
                  onTap: () {
                    context.read<SettingsCubit>().changeLocale(Locale(item.key));
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
