import 'package:get_it/get_it.dart';
import 'package:onix_bot/core/localizations/cubit/localization_cubit.dart';

/// TODO: update Masons!

final getIt = GetIt.instance;
void initGetIt() {

  

  /// BLoC
  getIt.registerFactory<LocalizationCubit>(() => LocalizationCubit());

  ///* Auth Injection

}
