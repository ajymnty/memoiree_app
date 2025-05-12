import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:memoiree/app/routes.dart';
import 'package:memoiree/presentation/screens/all/splash/splash.dart';
import 'package:memoiree/presentation/screens/all/splash/splash_cb.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();

  tz.setLocalLocation(tz.getLocation('Asia/Manila'));

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/launcher_icon');

  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings();

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) async {},
  );

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return ShadApp(
          debugShowCheckedModeBanner: false,
          title: 'Memoiree',

          // You can use the library anywhere in the app even in theme
          home: child,
        );
      },
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        getPages: appRoutes(),
        home: Splash(),
        initialBinding: SplashBinding(),
      ),
    );
  }
}
