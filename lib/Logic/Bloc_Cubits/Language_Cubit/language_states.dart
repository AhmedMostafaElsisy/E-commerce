import 'package:flutter/material.dart';

abstract class LangState {}

class AppInitialLangState extends LangState {}

class GetLangLangState extends LangState {}

class UpdateLangState extends LangState {
  Locale locale;

  UpdateLangState(this.locale);
}

class UpdateNewLangState extends LangState {
  Locale locale;

  UpdateNewLangState(this.locale);
}

class ErrorLangState extends LangState {
  final String error;

  ErrorLangState(this.error);
}
