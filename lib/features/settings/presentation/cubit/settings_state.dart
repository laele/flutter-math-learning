part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final bool isLoaded;
  final Locale? locale; // if null then use device lang

  const SettingsState({
    this.locale,
    this.isLoaded = false,
  });

  SettingsState copyWith({
    Locale? locale,
    bool? isLoaded,
  }) {
    return SettingsState(
      isLoaded: isLoaded ?? this.isLoaded,
      locale: locale ?? this.locale,
    );
  }

  @override
  List<Object?> get props => [locale, isLoaded];
}
