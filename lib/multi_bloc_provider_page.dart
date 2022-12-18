import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/Set_Destination_feature/presentation/logic/destination_cubit.dart';
import 'features/notification_feature/data/reposiroty/notification_repository.dart';

import 'core/Connectivity_Cubit/connectivity_cubit.dart';
import 'core/Language_Cubit/language_cubit.dart';
import 'features/Auth_feature/Presentation/logic/Login_Cubit/login_cubit.dart';
import 'features/Auth_feature/Presentation/logic/OTP_Cubit/otp_cubit.dart';
import 'features/Auth_feature/Presentation/logic/Password_Cubit/password_cubit.dart';
import 'features/Auth_feature/Presentation/logic/Sign_Up_Cubit/sign_up_cubit.dart';
import 'features/Home_feature/presentation/logic/Bottom_Nav_Cubit/bottom_nav_cubit.dart';
import 'features/Home_feature/presentation/logic/request_cubit/request_cubit.dart';
import 'features/Profile_feature/presentation/logic/Profile_Cubit/profile_cubit.dart';
import 'features/notification_feature/presentation/logic/notification_cubit.dart';
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
            create: (_) =>di.sl<ProfileCubit>()),
        BlocProvider<NotificationCubit>(
            create: (_) => NotificationCubit(NotificationListRepository())),
        BlocProvider<RequestCubit>(create: (_) => di.sl<RequestCubit>()),
        BlocProvider<DestinationCubit>(create: (_) => di.sl<DestinationCubit>()),
        BlocProvider<BottomNavCubit>(create: (_) => BottomNavCubit()),

      ],
      child: widget.body,
    );
  }
}
