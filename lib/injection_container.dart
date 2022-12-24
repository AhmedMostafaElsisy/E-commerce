import 'package:get_it/get_it.dart';
import 'core/Data_source/local_source/flutter_secured_storage.dart';
import 'core/setting_feature/Data/data_scources/local_data_scources.dart';
import 'core/setting_feature/Data/data_scources/remote_data_scource.dart';
import 'core/setting_feature/Data/repository/setting_repository.dart';
import 'core/setting_feature/Domain/repository/setting_interface.dart';
import 'core/setting_feature/Domain/ues_cases/setting_ues_cases.dart';
import 'core/setting_feature/Logic/setting_cubit.dart';
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
import 'features/Auth_feature/Presentation/logic/Login_Cubit/login_cubit.dart';
import 'features/Auth_feature/Presentation/logic/OTP_Cubit/otp_cubit.dart';
import 'features/Auth_feature/Presentation/logic/Password_Cubit/password_cubit.dart';
import 'features/Auth_feature/Presentation/logic/Sign_Up_Cubit/sign_up_cubit.dart';
import 'features/Auth_feature/Data/repository/otp_repository.dart';
import 'features/Auth_feature/Domain/repository/otp_interface.dart';
import 'features/Auth_feature/Domain/use_cases/otp_ues_cases.dart';
import 'features/Home_feature/Data/data_scources/request_remote_data_scources.dart';
import 'features/Home_feature/Data/repository/request_repository.dart';
import 'features/Home_feature/Domain/repository/request_interface.dart';
import 'features/Home_feature/Domain/use_cases/request_use_case.dart';
import 'features/Home_feature/presentation/logic/request_cubit/request_cubit.dart';
import 'features/Profile_feature/Data/data_scources/profile_remote_data_source.dart';
import 'features/Profile_feature/Data/repository/profile_repository.dart';
import 'features/Profile_feature/Domain/repository/profile_interface.dart';
import 'features/Profile_feature/Domain/user_cases/profile_ues_case.dart';
import 'features/Profile_feature/presentation/logic/Profile_Cubit/profile_cubit.dart';
import 'features/Set_Destination_feature/Data/data_scources/location_remote_data_scources.dart';
import 'features/Set_Destination_feature/Data/repository/location_repository.dart';
import 'features/Set_Destination_feature/Domain/location_ues_cases/location_ues_cases.dart';
import 'features/Set_Destination_feature/Domain/repository/location_interface.dart';
import 'features/Set_Destination_feature/presentation/logic/destination_cubit.dart';
import 'features/trip_feature/Domain/ues_cases/trip_ues_case.dart';
import 'features/trip_feature/logic/trip_cubit/trip_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  ///Bloc
  sl.registerFactory(() => LoginCubit(sl()));
  sl.registerFactory(() => SignUpCubit(sl()));
  sl.registerFactory(() => OtpCubit(sl()));
  sl.registerFactory(() => PasswordCubit(sl()));
  sl.registerFactory(() => RequestCubit(sl()));
  sl.registerFactory(() => ProfileCubit(sl()));
  sl.registerFactory(() => DestinationCubit(sl()));
  sl.registerFactory(() => TripCubit(sl()));
  sl.registerFactory(() => SettingCubit(sl()));

  ///User case
  sl.registerLazySingleton(() => AuthUserCase(repository: sl()));
  sl.registerLazySingleton(() => PasswordUesCases(sl(), sl()));
  sl.registerLazySingleton(() => OtpUesCases(sl()));
  sl.registerLazySingleton(() => RequestUesCases(sl()));
  sl.registerLazySingleton(() => ProfileUesCases(sl()));
  sl.registerLazySingleton(() => LocationUesCases(sl()));
  sl.registerLazySingleton(() => TripUesCases(sl()));
  sl.registerLazySingleton(() => SettingUserCase(repository: sl()));

  ///repo
  sl.registerLazySingleton<OtpRepositoryInterface>(() => OtpRepository(sl()));
  sl.registerLazySingleton<PasswordRepositoryInterface>(
      () => PasswordRepository(sl()));
  sl.registerLazySingleton<RequestRepositoryInterface>(
      () => RequestRepository(sl()));
  sl.registerLazySingleton<ProfileRepositoryInterface>(
      () => ProfileRepository(sl(), sl()));
  sl.registerLazySingleton<AuthRepositoryInterface>(() => AuthRepository(
      localDataSourceInterface: sl(), remoteDataSourceInterface: sl()));
  sl.registerLazySingleton<SettingRepositoryInterface>(() => SettingRepository(
    sl(),sl()
  ));
  sl.registerLazySingleton<LocationRepositoryInterface>(
      () => LocationRepository(sl()));

  ///auth local data source interface
  sl.registerLazySingleton<AuthLocalDataSourceInterface>(
      () => AuthLocalDataSourceImp(flutterSecureStorage: sl()));
  sl.registerLazySingleton<SettingLocalDataSourceInterface>(
      () => SettingLocalDataSourceImp(flutterSecureStorage: sl()));

  ///auth remote data source interface
  sl.registerLazySingleton<AuthRemoteDataSourceInterface>(
      () => AuthRemoteDataSourceImp());
  sl.registerLazySingleton<OtpRemoteDataSourceInterface>(
      () => OtpRemoteDataSourceImp());
  sl.registerLazySingleton<PasswordRemoteDataSourceInterface>(
      () => PasswordRemoteDataSourceImpl());
  sl.registerLazySingleton<RequestRemoteDataSourceInterface>(
      () => RequestRemoteDataSourceImpl());
  sl.registerLazySingleton<ProfileRemoteDataSourceInterface>(
      () => ProfileRemoteDataSourceImpl());
  sl.registerLazySingleton<LocationRemoteDataSourceInterface>(
      () => LocationRemoteDataSourceImpl());
  sl.registerLazySingleton<SettingRemoteDataSourceInterface>(
      () => SettingRemoteDataSourceImpl());

  ///local data source
  sl.registerLazySingleton(() => DefaultSecuredStorage());
}
