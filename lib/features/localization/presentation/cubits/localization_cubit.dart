import 'dart:convert';
import 'dart:ui';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../resources/strings_manager.dart';
import '../../locale/app_localizations_setup.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  final SharedPreferences sharedPreferences;
  LocalizationCubit({
    required this.sharedPreferences,
  }) : super(LocalizationInitial());

  late Locale selectedLocale;

  getLocale() {
    final String? jsonString =
        sharedPreferences.getString(StringsManager.storedLocale);
    if (jsonString != null) {
      String decodedJsonData = json.decode(jsonString);
      selectedLocale = Locale(decodedJsonData);
    }
    //
    else {
      _setSystemLocaleIfFound(false);
    }
  }

  Future setToSystemLocale() async {
    await sharedPreferences.remove(
      StringsManager.storedLocale,
    );
    _setSystemLocaleIfFound(true);
  }

  Future setLocale(Locale locale) async {
    await sharedPreferences.setString(
      StringsManager.storedLocale,
      json.encode(locale.languageCode),
    );

    selectedLocale = locale;
    emit(LocalizationSuccessState(locale: locale));
  }

  //The system (mobile) language
  Locale _getDeviceLocale() {
    final String result = Platform.localeName; //like en_US or ar_EG
    final String localeString = result.split('_').first;
    return Locale(localeString);
  }

  void _setSystemLocaleIfFound(bool emitState) {
    final Locale deviceLocal = _getDeviceLocale();
    Locale systemLocaleOrEnglish =
        AppLocalizationsSetup.localeResolutionCallback(
            deviceLocal, AppLocalizationsSetup.supportedLocales);
    //
    selectedLocale = systemLocaleOrEnglish;
    if (emitState) {
      emit(LocalizationSuccessState(locale: systemLocaleOrEnglish));
    }
  }
}
