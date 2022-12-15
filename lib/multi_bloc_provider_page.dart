import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Data/Remote_Data/Repositories/ProfileRepository.dart';
import 'Data/Remote_Data/Repositories/notification_repository.dart';
import 'Logic/Bloc_Cubits/Help_Cubit/help_cubit.dart';
import 'Logic/Bloc_Cubits/Language_Cubit/language_cubit.dart';
import 'Logic/Bloc_Cubits/Notification_Cubit/notification_cubit.dart';
import 'Logic/Bloc_Cubits/Profile_Cubit/profile_cubit.dart';
import 'Logic/Bloc_Cubits/Setting_Cubit/setting_cubit.dart';
import 'core/Connectivity_Cubit/connectivity_cubit.dart';
import 'features/Auth_feature/Presentation/logic/Login_Cubit/login_cubit.dart';
import 'features/Auth_feature/Presentation/logic/OTP_Cubit/otp_cubit.dart';
import 'features/Auth_feature/Presentation/logic/Password_Cubit/password_cubit.dart';
import 'features/Auth_feature/Presentation/logic/Sign_Up_Cubit/sign_up_cubit.dart';
import 'features/Home_feature/presentation/logic/Bottom_Nav_Cubit/bottom_nav_cubit.dart';
import 'features/Home_feature/presentation/logic/request_cubit/request_cubit.dart';
import 'injection_container.dart' as di;

class MultiBlocProvidersPage extends StatefulWidget {
  final Widget body;

  const MultiBlocProvidersPage({Key? key, required this.body})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiBlocProvidersPageState();
}

class _MultiBlocProvidersPageState extends State<MultiBlocProvidersPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LangCubit>(
            lazy: false, create: (_) => LangCubit()..getLang()),
        BlocProvider<ConnectivityCubit>(
            lazy: false, create: (_) => ConnectivityCubit()..initConnection()),
        BlocProvider<LoginCubit>(
            lazy: false,
            create: (_) =>  di.sl<LoginCubit>()),
        BlocProvider<SignUpCubit>(
            create: (_) => di.sl<SignUpCubit>()),
        BlocProvider<OtpCubit>(create: (_) => di.sl<OtpCubit>()),
        BlocProvider<PasswordCubit>(
            create: (_) => di.sl<PasswordCubit>()),
        BlocProvider<ProfileCubit>(
            create: (_) => ProfileCubit(ProfileRepository())),
        BlocProvider<HelpCubit>(create: (_) => HelpCubit()),
        BlocProvider<NotificationCubit>(
            create: (_) => NotificationCubit(NotificationListRepository())),
        BlocProvider<SettingCubit>(create: (_) => di.sl<SettingCubit>()),
        BlocProvider<RequestCubit>(create: (_) => di.sl<RequestCubit>()),
        BlocProvider<BottomNavCubit>(create: (_) => BottomNavCubit()),

      ],
      child: widget.body,
    );
  }
}
