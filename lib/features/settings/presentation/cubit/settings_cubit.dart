import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_math_app/features/settings/domain/repository/settings_repository.dart';
import 'package:flutter/material.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository _repository;

  SettingsCubit({
    required SettingsRepository repository,
  }) : _repository = repository,
       super(SettingsState());

  Future<void> loadSavedLocale() async {
    final result = await _repository.getLocaleCode();
    result.fold(
      (failure) => emit(state.copyWith(locale: null)),
      (localeCode) => emit(state.copyWith(locale: localeCode != null ? Locale(localeCode) : null)),
    );
  }

  Future<void> changeLocale(Locale? locale) async {
    emit(state.copyWith(locale: locale));
    await _repository.saveLocaleCode(code: locale?.languageCode);
  }
}
