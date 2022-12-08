import 'package:get_it/get_it.dart';

import 'Data/Interfaces/settings_interface.dart';
import 'Data/Remote_Data/Repositories/setting_repository.dart';
import 'Domain/UesCases/setting_ues_case.dart';
import 'Logic/Bloc_Cubits/Setting_Cubit/setting_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  ///Bloc
  sl.registerFactory(() => SettingCubit(repo: sl()));

  ///User case
  sl.registerLazySingleton(() => SettingUesCase(repository: sl()));

  ///repo
  sl.registerLazySingleton<SettingInterfaceRepository>(
      () => SettingRepository());
}
