import 'dart:convert';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:localization_theme_mvc/features/general/services/general_repo.dart';

import '../../../../resources/app_strings.dart';
import '../../locale/app_localizations_setup.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  final GeneralRepo generalRepo;
  LocalizationCubit({
    required this.generalRepo,
  }) : super(LocalizationInitial());

  late Locale selectedLocale;

  getLocale() {
    final String? jsonString = generalRepo.getString(AppStrings.storedLocale);
    if (jsonString != null) {
      String decodedJsonData = json.decode(jsonString);
      selectedLocale = Locale(decodedJsonData);
    }
    //
    else {
      _setSystemLocaleIfFound(emitState: false);
    }
  }

  Future setToSystemLocale() async {
    await generalRepo.removeKey(
      AppStrings.storedLocale,
    );
    _setSystemLocaleIfFound(emitState: true);
  }

  Future setLocale(Locale locale) async {
    await generalRepo.setString(
      AppStrings.storedLocale,
      json.encode(locale.languageCode),
    );

    selectedLocale = locale;
    emit(LocalizationSuccessState(locale: locale));
  }

  //The system (Web,mobile) language
  Locale _getDeviceLocale() {
    // final String result = Platform.localeName; //like en_US or ar_EG
    // final String localeString = result.split('_').first;
    // return Locale(localeString);
    //
    Locale locale = window.locale;
    return locale;
  }

  void _setSystemLocaleIfFound({required bool emitState}) {
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
