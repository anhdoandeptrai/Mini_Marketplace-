import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  static const String _languageCodeKey = 'language_code';
  final SharedPreferences sharedPreferences;

  LanguageCubit({required this.sharedPreferences})
    : super(LanguageState(_getInitialLocale(sharedPreferences)));

  static Locale _getInitialLocale(SharedPreferences prefs) {
    final languageCode = prefs.getString(_languageCodeKey);
    if (languageCode != null) {
      return Locale(languageCode);
    }
    // Default to Vietnamese
    return const Locale('vi');
  }

  Future<void> changeLanguage(String languageCode) async {
    await sharedPreferences.setString(_languageCodeKey, languageCode);
    emit(LanguageState(Locale(languageCode)));
  }

  Future<void> toggleLanguage() async {
    final newLanguageCode = state.locale.languageCode == 'vi' ? 'en' : 'vi';
    await changeLanguage(newLanguageCode);
  }
}
