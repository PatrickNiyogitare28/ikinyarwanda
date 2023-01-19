import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:ikinyarwanda/interface/router.dart';
import 'package:ikinyarwanda/interface/views/home_view/home_view.dart';
import 'package:ikinyarwanda/services/dialog_service.dart';
import 'package:ikinyarwanda/services/navigation_service.dart';
import 'package:ikinyarwanda/shared/colors.dart';
import 'package:ikinyarwanda/utils/dialog_manager.dart';
import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';

import 'locator.dart';
import 'shared/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize all services
  await setupLocator();

  // allow only portrait mode
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

  final brightness = SchedulerBinding.instance.window.platformBrightness;
  bool isDark = brightness == Brightness.dark;

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: isDark ? Brightness.light : Brightness.dark,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      systemNavigationBarColor:
          isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      systemNavigationBarDividerColor:
          isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      systemNavigationBarIconBrightness:
          isDark ? Brightness.light : Brightness.dark,
    ),
  );

  configureApp();

  runApp(const Ikinyarwanda());
}

class Ikinyarwanda extends StatelessWidget {
  const Ikinyarwanda({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ikinyarwanda',
      home: const HomeView(),
      theme: ThemeConfig.lightTheme,
      darkTheme: ThemeConfig.darkTheme,
      themeMode: ThemeMode.system,
      navigatorKey: locator<NavigationService>().navigationKey,
      onGenerateRoute: generateRoute,
      builder: (context, child) => Navigator(
        key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) => DialogManager(
            child: child!,
          ),
        ),
      ),
    );
  }
}
