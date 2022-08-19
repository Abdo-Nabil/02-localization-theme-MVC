import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../../resources/strings_manager.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final SharedPreferences sharedPreferences;
  ThemeCubit({required this.sharedPreferences}) : super(ThemeInitial());

  late ThemeMode selectedThemeMode;

  getTheme() {
    final bool? isLightTheme =
        sharedPreferences.getBool(StringsManager.isLightTheme);
    if (isLightTheme != null) {
      isLightTheme
          ? selectedThemeMode = ThemeMode.light
          : selectedThemeMode = ThemeMode.dark;
    }
    //
    else {
      selectedThemeMode = ThemeMode.system;
    }
  }

  setTheme(ThemeMode themeMode) async {
    switch (themeMode) {
      //
      case ThemeMode.system:
        {
          await sharedPreferences.remove(StringsManager.isLightTheme);
          selectedThemeMode = ThemeMode.system;
          emit(ThemeChangedState(themeMode));
        }
        break;
      //
      case ThemeMode.light:
        {
          await sharedPreferences.setBool(StringsManager.isLightTheme, true);
          selectedThemeMode = ThemeMode.light;
          emit(ThemeChangedState(themeMode));
        }
        break;
      //
      case ThemeMode.dark:
        {
          await sharedPreferences.setBool(StringsManager.isLightTheme, false);
          selectedThemeMode = ThemeMode.dark;
          emit(ThemeChangedState(themeMode));
        }
        break;
      //
    }
  }
}

// @override
// Future<Unit> setLocale(LocaleModel localeModel) async {
//   final bool result = await sharedPreferences.setString(
//     StringsManager.storedLocale,
//     json.encode(localeModel.locale.languageCode),
//   );
//   if (result == false) {
//     throw CacheSavingException();
//   }
//   return Future.value(unit);
// }
