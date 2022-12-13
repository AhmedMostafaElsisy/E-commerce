import 'package:get_it/get_it.dart';

import 'Data/Interfaces/settings_interface.dart';
import 'Data/Remote_Data/Repositories/setting_repository.dart';
import 'Data/local_source/flutter_secured_storage.dart';
import 'Domain/UesCases/setting_ues_case.dart';
import 'Logic/Bloc_Cubits/Setting_Cubit/setting_cubit.dart';
import 'features/Auth_feature/Data/data_scources/auth_local_data_source.dart';
import 'features/Auth_feature/Data/data_scources/auth_remote_data_source.dart';
import 'features/Auth_feature/Data/data_scources/otp_remote_data_scources.dart';
import 'features/Auth_feature/Data/data_scources/password_remote_data_scources.dart';
import 'features/Auth_feature/Data/repository/auth_repository.dart';
import 'features/Auth_feature/Data/repository/password_repository.dart';
import 'features/Auth_feature/Domain/repository/auth_interface.dart';
import 'features/Auth_feature/Domain/repository/password_interface.dart';
import 'features/Auth_feature/Domain/use_cases/auth_use_case.dart';
import 'features/Auth_feature/Domain/use_cases/forget_password_user_case.dart';
import 'features/Auth_feature/Presentation/logic/Forget_Password_Cubit/forget_password_cubit.dart';
import 'features/Auth_feature/Presentation/logic/Login_Cubit/login_cubit.dart';
import 'features/Auth_feature/Presentation/logic/OTP_Cubit/otp_cubit.dart';
import 'features/Auth_feature/Presentation/logic/Sign_Up_Cubit/sign_up_cubit.dart';
import 'features/Auth_feature/Data/repository/otp_repository.dart';
import 'features/Auth_feature/Domain/repository/otp_interface.dart';
import 'features/Auth_feature/Domain/use_cases/otp_ues_cases.dart';

final sl = GetIt.instance;

Future<void> init() async {
  ///Bloc
  sl.registerFactory(() => SettingCubit(repo: sl()));
  sl.registerFactory(() => LoginCubit(sl()));
  sl.registerFactory(() => SignUpCubit(sl()));
  sl.registerFactory(() => OtpCubit(sl()));
  sl.registerFactory(() => ForgetPasswordCubit(sl()));

  ///User case
  sl.registerLazySingleton(() => SettingUesCase(repository: sl()));
  sl.registerLazySingleton(() => AuthUserCase(repository: sl()));
  sl.registerLazySingleton(() => OtpUesCases(sl()));
  sl.registerLazySingleton(() => ForgetPasswordUesCases(sl(), sl()));

  ///repo
  sl.registerLazySingleton<SettingInterfaceRepository>(
      () => SettingRepository());
  sl.registerLazySingleton<OtpRepositoryInterface>(() => OtpRepository(sl()));
  sl.registerLazySingleton<PasswordRepositoryInterface>(() => PasswordRepository(sl()));
  sl.registerLazySingleton<AuthRepositoryInterface>(() => AuthRepository(
      localDataSourceInterface: sl(), remoteDataSourceInterface: sl()));

  ///auth local data source interface
  sl.registerLazySingleton<AuthLocalDataSourceInterface>(
      () => AuthLocalDataSourceImp(flutterSecureStorage: sl()));

  ///auth remote data source interface
  sl.registerLazySingleton<AuthRemoteDataSourceInterface>(
      () => AuthRemoteDataSourceImp());
  sl.registerLazySingleton<OtpRemoteDataSourceInterface>(
      () => OtpRemoteDataSourceImp());
  sl.registerLazySingleton<PasswordRemoteDataSourceInterface>(
      () => PasswordRemoteDataSourceImpl());

  ///local data source
  sl.registerLazySingleton(() => DefaultSecuredStorage());
}
