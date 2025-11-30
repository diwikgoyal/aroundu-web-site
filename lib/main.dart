import 'package:aroundu/constants/appRoutes.dart';
import 'package:aroundu/constants/firebase_options.dart';
import 'package:aroundu/designs/colors.designs.dart';
import 'package:aroundu/designs/utils.designs.dart';
import 'package:aroundu/utils/app_lifecycle_service.dart';
import 'package:aroundu/utils/route_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  await DesignUtils.lockPortraitOrientation();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase initialized successfully!');
  } catch (e) {
    print('Failed to initialize Firebase: $e');
  }
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // For web, we should enable all orientations
    DesignUtils.enableAllOrientations();

    return GetMaterialApp(
      navigatorKey: navigatorKey,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FlutterQuillLocalizations.delegate,
      ],
      navigatorObservers: [RiverpodRouteObserver(ref)],
      debugShowCheckedModeBanner: false,
      title: 'AroundU',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: DesignColors.accent),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.landing,
      getPages: RouteService().configureRoutes(),
      routingCallback: RouteService().handleRouteChange,
      onGenerateInitialRoutes: RouteService().generateInitialRoutes,
      onGenerateRoute: RouteService().generateRoute,
      // home: SplashView(),
    );
    // ScreenUtilInit(
    //   designSize: Size(
    //     // DesignUtils.kFigmaScreenWidth,

    //     // DesignUtils.kFigmaScreenHeight,
    //     //phone
    //     // 360,
    //     // 690,
    //     //tablet
    //     // 768,
    //     // 1024,
    //     //desktop
    //     1280,
    //     800,
    //   ),
    //   minTextAdapt: true,
    //   splitScreenMode: true,
    //   builder: (context, child) {
    //     return
    //   },
    // );
  }
}
