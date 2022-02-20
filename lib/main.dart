// import 'package:firebase_core/firebase_core.dart';
import 'package:default_repo_app/Logic/Bloc_Cubits/Connectivity_Cubit/connectivity_cubit.dart';
import 'package:default_repo_app/Logic/Bloc_Cubits/Connectivity_Cubit/connectivity_states.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'Constants/app_theme.dart';
import 'Data/Dio_Exception_Handling/dio_helper.dart';
import 'Helpers/Observers/bloc_observer.dart';
import 'Helpers/Responsive_UI/ui_components.dart';
import 'Helpers/shared_texts.dart';
import 'Logic/Bloc_Cubits/Language_Cubit/language_cubit.dart';
import 'Logic/Bloc_Cubits/Language_Cubit/language_states.dart';
import 'Routes/route_generator.dart';
import 'Screens/Splash_Screens/splash_screen_home_page.dart';
import 'multi_bloc_provider_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  GestureBinding.instance?.resamplingEnabled = true;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: SystemUiOverlay.values);

  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    DioHelper.init();
  }

  @override
  Widget build(BuildContext context) {
    return const MultiBlocProvidersPage(body: HomeMaterialApp());
  }
}

class HomeMaterialApp extends StatelessWidget {
  const HomeMaterialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConnectivityCubit, ConnectivityState>(
      builder: (connectivityCxt, connectivityState) {
        return BlocConsumer<LangCubit, LangState>(
          listener: (context, appState) {},
          builder: (langContext, appState) {
            return MaterialApp(
              onGenerateRoute: RouteGenerator.generateRoute,
              title: 'App Title',
              theme: lightTheme,
              debugShowCheckedModeBanner: false,
              locale: LangCubit.get(langContext).appLocal,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,

              /// widget that calculate width and height and type
              home: InfoComponents(
                builder: (infoComponentsContext, deviceInfo) {
                  SharedText.screenHeight = deviceInfo.screenHeight;
                  SharedText.screenWidth = deviceInfo.screenWidth;
                  SharedText.deviceType = deviceInfo;
                  SharedText.currentLocale =
                      LangCubit.get(context).appLocal!.languageCode;
                  return const SplashHomePage();
                },
              ),
            );
          },
        );
      },
      listener: (connectivityCxt, connectivityState) {},
    );
  }
}
