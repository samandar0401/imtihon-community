import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/l10n/app_localization.dart';
import '../LogInPage.dart';

void main() {
  runApp(const LoginView());
}

class LocalizationViewModel extends ChangeNotifier {
  Locale _currentLocale = Locale("uz");

  Locale get currentLocale => _currentLocale;

  LocalizationViewModel() {
    _loadLocale();
  }

  void setLocale(Locale locale) async {
    _currentLocale = locale;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("selected_locale", locale.languageCode);
  }

  void _loadLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? langCode = prefs.getString("selected_locale");

    if (langCode != null) {
      _currentLocale = Locale(langCode);
      notifyListeners();
    }
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LocalizationViewModel(),
        ),
      ],
      builder: (context, child) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          MyLocalizations.delegate,
        ],
        supportedLocales: [Locale("uz"), Locale("en"), Locale("ru")],
        locale: context.watch<LocalizationViewModel>().currentLocale,
        debugShowCheckedModeBanner: false,
        home: CategoryPage(),
      ),
    );
  }
}
