import 'package:default_repo_app/Logic/Bloc_Cubits/Connectivity_Cubit/connectivity_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Logic/Bloc_Cubits/Forget_Password_Cubit/forget_password_cubit.dart';
import 'Logic/Bloc_Cubits/Help_Cubit/help_cubit.dart';
import 'Logic/Bloc_Cubits/Language_Cubit/language_cubit.dart';
import 'Logic/Bloc_Cubits/Login_Cubit/login_cubit.dart';
import 'Logic/Bloc_Cubits/OTP_Cubit/otp_cubit.dart';
import 'Logic/Bloc_Cubits/Profile_Cubit/profile_cubit.dart';
import 'Logic/Bloc_Cubits/Setting_Cubit/setting_cubit.dart';
import 'Logic/Bloc_Cubits/Sign_Up_Cubit/sign_up_cubit.dart';
import 'Logic/Repositories/user_repository.dart';

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
            create: (_) => LoginCubit(UserRepository())..startApp()),
        BlocProvider<SignUpCubit>(create: (_) => SignUpCubit()),
        BlocProvider<OtpCubit>(create: (_) => OtpCubit()),
        BlocProvider<ForgetPasswordCubit>(create: (_) => ForgetPasswordCubit()),
        BlocProvider<ProfileCubit>(create: (_) => ProfileCubit()),
        BlocProvider<HelpCubit>(create: (_) => HelpCubit()),
        BlocProvider<SettingCubit>(create: (_) => SettingCubit()),
      ],
      child: widget.body,
    );
  }
}
