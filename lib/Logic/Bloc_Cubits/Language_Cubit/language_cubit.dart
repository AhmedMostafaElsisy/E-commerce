import 'package:default_repo_app/Data/local_source/flutter_secured_storage.dart';
import 'package:default_repo_app/Helpers/shared_texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'language_states.dart';

class LangCubit extends Cubit<LangState> {
  LangCubit() : super(AppInitialLangState());
  Locale? appLocal;

  static LangCubit get(context) => BlocProvider.of(context);
  String currentLang = "en";

  /// change lang with the new lang selected
  Future<void> changeLang(newLang, context) async {
    ///update current lang
    currentLang = newLang;
    debugPrint("new lang is $newLang");

    ///update shared lang
    SharedText.currentLocale = currentLang;

    ///save new lang
    DefaultSecuredStorage.setLang(newLang);

    ///update delegate with new lang
    appLocal = Locale(newLang);
    await AppLocalizations.delegate.load(appLocal!);
    emit(UpdateNewLangState(appLocal!));
  }

  ///get saved lang (called when app is opening)
  getLang() {
    emit(GetLangLangState());

    ///check if the lang has date
    DefaultSecuredStorage.getLang().then((lang) {
      /// save current lang
      if (lang == null) {
        debugPrint("saved lang is null");
        DefaultSecuredStorage.setLang(currentLang);
      }

      /// get saved lang
      else {
        debugPrint("lang value is $lang");
        currentLang = lang;
      }
    });
    debugPrint("currentLang value is $currentLang");

    /// set the locale with saved lang
    appLocal = Locale(currentLang);
    SharedText.currentLocale = currentLang;
    debugPrint("app local lang code is ${appLocal!.languageCode}");

    ///set delegate with saved lang
    AppLocalizations.delegate.load(appLocal!);
    currentLang = appLocal.toString();
    emit(UpdateLangState(appLocal!));
  }
}
