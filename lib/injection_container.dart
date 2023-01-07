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
import 'features/Auth_feature/Data/repository/otp_repository.dart';
import 'features/Auth_feature/Data/repository/password_repository.dart';
import 'features/Auth_feature/Domain/repository/auth_interface.dart';
import 'features/Auth_feature/Domain/repository/otp_interface.dart';
import 'features/Auth_feature/Domain/repository/password_interface.dart';
import 'features/Auth_feature/Domain/use_cases/auth_use_case.dart';
import 'features/Auth_feature/Domain/use_cases/forget_password_user_case.dart';
import 'features/Auth_feature/Domain/use_cases/otp_ues_cases.dart';
import 'features/Auth_feature/Presentation/logic/Login_Cubit/login_cubit.dart';
import 'features/Auth_feature/Presentation/logic/OTP_Cubit/otp_cubit.dart';
import 'features/Auth_feature/Presentation/logic/Password_Cubit/password_cubit.dart';
import 'features/Auth_feature/Presentation/logic/Sign_Up_Cubit/sign_up_cubit.dart';
import 'features/Home_feature/Data/data_sources/home_remote_data_sources.dart';
import 'features/Home_feature/Data/repository/home_repository.dart';
import 'features/Home_feature/Domain/repository/home_interface.dart';
import 'features/Home_feature/Domain/use_cases/home_use_case.dart';
import 'features/Home_feature/presentation/logic/request_cubit/home_cubit.dart';
import 'features/Profile_feature/Data/data_scources/profile_remote_data_source.dart';
import 'features/Profile_feature/Data/repository/profile_repository.dart';
import 'features/Profile_feature/Domain/repository/profile_interface.dart';
import 'features/Profile_feature/Domain/user_cases/profile_ues_case.dart';
import 'features/Profile_feature/presentation/logic/Profile_Cubit/profile_cubit.dart';
import 'features/favorite_feature/data/data_scoures/favorite_remote_data_scoures.dart';
import 'features/favorite_feature/data/repository/favorite_repository.dart';
import 'features/favorite_feature/domain/repository/favorite_repository_interface.dart';
import 'features/favorite_feature/domain/ues_cases/ues_cases.dart';
import 'features/favorite_feature/presentation/logic/favorite_cubit.dart';
import 'features/rating_feature/Data/data_scoures/remote_data_scoures.dart';
import 'features/rating_feature/Data/repository/rating_repository.dart';
import 'features/rating_feature/Domain/repository/repository_interface.dart';
import 'features/rating_feature/Domain/ues_cases/rating_ues_cases.dart';
import 'features/rating_feature/presentation/logic/rating_cubit.dart';
import 'features/store_feature/data/data_scoures/remote_data_scoures.dart';
import 'features/store_feature/data/repository/my_store_repository.dart';
import 'features/store_feature/domain/repository/store_repository_interface.dart';
import 'features/store_feature/domain/ues_cases/ues_cases.dart';
import 'features/store_feature/presentation/logic/store_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  ///Bloc
  sl.registerFactory(() => LoginCubit(sl()));
  sl.registerFactory(() => SignUpCubit(sl()));
  sl.registerFactory(() => OtpCubit(sl()));
  sl.registerFactory(() => PasswordCubit(sl()));
  sl.registerFactory(() => HomeCubit(sl()));
  sl.registerFactory(() => ProfileCubit(sl()));
  sl.registerFactory(() => SettingCubit(sl()));
  sl.registerFactory(() => RatingCubit(sl()));
  sl.registerFactory(() => FavoriteCubit(sl()));
  sl.registerFactory(() => StoreCubit(sl()));

  ///User case
  sl.registerLazySingleton(() => AuthUserCase(repository: sl()));
  sl.registerLazySingleton(() => PasswordUesCases(sl(), sl()));
  sl.registerLazySingleton(() => OtpUesCases(sl()));
  sl.registerLazySingleton(() => HomeUesCases(sl()));
  sl.registerLazySingleton(() => ProfileUesCases(sl()));
  sl.registerLazySingleton(() => RatingUesCases(sl()));
  sl.registerLazySingleton(() => FavoriteUesCase(sl()));
  sl.registerLazySingleton(() => StoreUesCase(sl()));
  sl.registerLazySingleton(() => SettingUserCase(repository: sl()));

  ///repo
  sl.registerLazySingleton<FavoriteRepositoryInterface>(
      () => FavoriteRepository(sl()));
  sl.registerLazySingleton<OtpRepositoryInterface>(() => OtpRepository(sl()));
  sl.registerLazySingleton<RatingRepositoryInterface>(
      () => RatingRepository(sl()));
  sl.registerLazySingleton<PasswordRepositoryInterface>(
      () => PasswordRepository(sl()));
  sl.registerLazySingleton<HomeRepositoryInterface>(() => HomeRepository(sl()));
  sl.registerLazySingleton<ProfileRepositoryInterface>(
      () => ProfileRepository(sl(), sl()));
  sl.registerLazySingleton<AuthRepositoryInterface>(() => AuthRepository(
      localDataSourceInterface: sl(), remoteDataSourceInterface: sl()));
  sl.registerLazySingleton<SettingRepositoryInterface>(
      () => SettingRepository(sl(), sl()));
  sl.registerLazySingleton<StoreRepositoryInterface>(
      () => StoreRepository(sl()));

  ///auth local data source interface
  sl.registerLazySingleton<AuthLocalDataSourceInterface>(
      () => AuthLocalDataSourceImp(flutterSecureStorage: sl()));
  sl.registerLazySingleton<SettingLocalDataSourceInterface>(
      () => SettingLocalDataSourceImp(flutterSecureStorage: sl()));

  ///auth remote data source interface
  sl.registerLazySingleton<FavoriteRemoteDataSourceInterface>(
      () => FavoriteRemoteDataSourceImpl());
  sl.registerLazySingleton<AuthRemoteDataSourceInterface>(
      () => AuthRemoteDataSourceImp());
  sl.registerLazySingleton<OtpRemoteDataSourceInterface>(
      () => OtpRemoteDataSourceImp());
  sl.registerLazySingleton<PasswordRemoteDataSourceInterface>(
      () => PasswordRemoteDataSourceImpl());
  sl.registerLazySingleton<HomeRemoteDataSourceInterface>(
      () => HomeRemoteDataSourceImpl());
  sl.registerLazySingleton<ProfileRemoteDataSourceInterface>(
      () => ProfileRemoteDataSourceImpl());
  sl.registerLazySingleton<SettingRemoteDataSourceInterface>(
      () => SettingRemoteDataSourceImpl());
  sl.registerLazySingleton<RatingRemoteDataSourceInterface>(
      () => RatingRemoteDataSourceImpl());
  sl.registerLazySingleton<StoreRemoteDataSourceInterface>(
      () => StoreRemoteDataSourceImpl());

  ///local data source
  sl.registerLazySingleton(() => DefaultSecuredStorage());
}
