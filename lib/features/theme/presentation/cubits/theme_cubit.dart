import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:localization_theme_mvc/features/general/services/general_repo.dart';

import '../../../../resources/app_strings.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final GeneralRepo generalRepo;
  ThemeCubit({required this.generalRepo}) : super(ThemeInitial());

  late ThemeMode selectedThemeMode;

  getTheme() {
    final bool? isLightTheme = generalRepo.getBool(AppStrings.isLightTheme);
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
          await generalRepo.removeKey(AppStrings.isLightTheme);
          selectedThemeMode = ThemeMode.system;
          emit(ThemeChangedState(themeMode));
        }
        break;
      //
      case ThemeMode.light:
        {
          await generalRepo.setBool(AppStrings.isLightTheme, true);
          selectedThemeMode = ThemeMode.light;
          emit(ThemeChangedState(themeMode));
        }
        break;
      //
      case ThemeMode.dark:
        {
          await generalRepo.setBool(AppStrings.isLightTheme, false);
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
