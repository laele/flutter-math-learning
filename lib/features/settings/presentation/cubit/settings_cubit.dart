import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_math_app/core/utils/locale_resolver.dart';
import 'package:flutter_math_app/features/dialog_message/domain/repositories/dialog_message_repository.dart';
import 'package:flutter_math_app/features/settings/domain/repository/settings_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository _settingsRepository;
  final DialogMessageRepository _dialogMessageRepository;

  SettingsCubit({
    required SettingsRepository settingsRepository,
    required DialogMessageRepository dialogRepository,
  }) : _settingsRepository = settingsRepository,
       _dialogMessageRepository = dialogRepository,
       super(SettingsState());

  Future<void> loadSavedLocale() async {
    final result = await _settingsRepository.getLocaleCode();
    result.fold(
      (failure) {
        emit(
          state.copyWith(locale: Locale(_deviceLanguageCode()), isLoaded: true),
        );
        _dialogMessageRepository.setLocale(languageCode: _deviceLanguageCode());
      },
      (localeCode) {
        emit(
          state.copyWith(
            isLoaded: true,
            locale: localeCode != null
                ? Locale(localeCode)
                : Locale(_deviceLanguageCode()),
          ),
        );
        _dialogMessageRepository.setLocale(
          languageCode: localeCode ?? _deviceLanguageCode(),
        );
      },
    );
  }

  Future<void> changeLocale({required String localeCode}) async {
    emit(state.copyWith(locale: Locale(localeCode)));
    await _settingsRepository.saveLocaleCode(code: localeCode);
    _dialogMessageRepository.setLocale(languageCode: localeCode);
  }

  String _deviceLanguageCode() {
    return LocaleResolver.resolveDeviceLanguage();
  }
}
