import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onix_bot/core/app_cache_keys.dart';
import 'package:onix_bot/core/caching_service.dart';
import 'package:onix_bot/core/injection/injector.dart';
import 'package:onix_bot/core/localizations/app_localization.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit() : super(LocalizationInit(const Locale('ar')));

  String lang = 'ar';

  static LocalizationCubit get(context) =>
      BlocProvider.of<LocalizationCubit>(context);

  // Getter to retrieve the current locale
  Locale get currentLocale => state.locale;
  int get currentLangIndex => state.locale.languageCode == 'ar' ? 1 : 2;

  void loadInitialLocale() async {
    final locale = getIt<CachingService>().getCached(AppCacheKeys.locale);
    // print("localeText =======>>>>>>>>> ${localeText.t}");
    if (locale != null) {
      if (locale == AppLocalization.supportedLocales.first.toString()) {
        lang = "ar";
        emit(LocalizationChange(AppLocalization.supportedLocales.first));
      } else if (locale == AppLocalization.supportedLocales.last.toString()) {
        lang = "en";
        emit(LocalizationChange(AppLocalization.supportedLocales.last));
      }
    }
  }

  // Function to change the language
  Future<void> changeLanguage(String newLang) async {
    lang = newLang;
    if (newLang == "ar") {
      getIt<CachingService>().cache(AppCacheKeys.locale, AppLocalization.supportedLocales.first.toString());
      emit(LocalizationChange(AppLocalization.supportedLocales.first));
    } else {
      getIt<CachingService>().cache(AppCacheKeys.locale, AppLocalization.supportedLocales.last.toString());
      emit(LocalizationChange(AppLocalization.supportedLocales.last));
    }
  }
}
