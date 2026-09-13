import 'package:shared_preferences/shared_preferences.dart';

import '../domain/models.dart';

class SettingsStore {
  static const _themeKey = 'theme';
  static const _remindKey = 'remind_days';
  static const _notifKey = 'notifications_enabled';
  static const _languageKey = 'language';

  Future<AppSettings> load() async {
    final prefs = await SharedPreferences.getInstance();
    final themeName = prefs.getString(_themeKey) ?? ThemePreference.system.name;
    final remind = prefs.getString(_remindKey) ?? '90,30,7';
    final languageName =
        prefs.getString(_languageKey) ?? AppLanguage.system.name;
    return AppSettings(
      theme: ThemePreference.values.byName(themeName),
      defaultRemindDays: remind.split(',').map(int.parse).toList(),
      notificationsEnabled: prefs.getBool(_notifKey) ?? true,
      language: AppLanguage.values.byName(languageName),
    );
  }

  Future<void> save(AppSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, settings.theme.name);
    await prefs.setString(_remindKey, settings.defaultRemindDays.join(','));
    await prefs.setBool(_notifKey, settings.notificationsEnabled);
    await prefs.setString(_languageKey, settings.language.name);
  }
}
