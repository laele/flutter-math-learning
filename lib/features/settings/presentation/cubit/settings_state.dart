part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final Locale? locale; // if null then use device lang

  const SettingsState({this.locale});

  SettingsState copyWith({
    Locale? locale,
  }) {
    return SettingsState(
      locale: locale ?? this.locale,
    );
  }

  @override
  List<Object?> get props => [locale];
}
