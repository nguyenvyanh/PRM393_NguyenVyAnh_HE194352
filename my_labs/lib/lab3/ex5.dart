class Settings {
  static final Settings _instance = Settings._internal();

  String theme = 'Light';
  bool notificationsEnabled = true;
  Settings._internal();

  factory Settings() {
    return _instance;
  }

  @override
  String toString() {
    return 'Settings(theme: $theme, notificationsEnabled: $notificationsEnabled)';
  }
}

void main() {
  final settingsA = Settings();
  final settingsB = Settings();

  settingsA.theme = 'Dark';

  print('Settings A: $settingsA');
  print('Settings B: $settingsB');

  print('Are both instances identical? ${identical(settingsA, settingsB)}');

}
