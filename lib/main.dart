import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:wl_delivery/model/api/APIManager/api_manager.dart';
import 'package:wl_delivery/model/db/db_provider.dart';
import 'package:wl_delivery/model/db/models/user.dart';
import 'package:wl_delivery/router/back_dispatcher.dart';
import 'package:wl_delivery/router/route_parser.dart';
import 'package:wl_delivery/router/router_delegate.dart';
import 'package:wl_delivery/router/ui_pages.dart';
import 'package:wl_delivery/model/repository/auth_repository.dart';

const String boxName = "db";

void main() async {

  // debugPaintPointersEnabled = true;
  // debugPaintSizeEnabled = true;

  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>(boxName);
  
  final dbPath = await DBProvider.initDB('app.db');
  final dbProvider = DBProvider();
  await dbProvider.open(dbPath);

  Get.put(dbProvider);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final delegate = AppRouterDelegate();
  final parser = RouteParser();
  MyBackButtonDispatcher? backButtonDispatcher;
  late AuthRepository authRepository;

  _MyAppState() {
    backButtonDispatcher = MyBackButtonDispatcher(delegate);

    authRepository = AuthRepository();
    final apiManager = APIManager(authReceivedDelegate: authRepository);
    authRepository.apiManager = apiManager;
    Get.put(apiManager);
    Get.put(authRepository);
    delegate.setNewRoutePath(SplashPageConfig);
    Get.put(delegate);
  }

  @override
  initState() {
    super.initState();

    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {

    if ((await authRepository.accessToken) == null) {
      delegate.setNewRoutePath(LoginPageConfig);
    } else {
      delegate.setNewRoutePath(NavigationBarPageConfig);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => authRepository,
      child: BlocListener<AuthRepository, AuthState>(
        listener: (context, state) {
          if (state is LoggedInAuthState) {
            delegate.setNewRoutePath(NavigationBarPageConfig);
          } else {
            delegate.setNewRoutePath(LoginPageConfig);
          }
        },
        child: MaterialApp.router(
          title: 'Navigation App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              pageTransitionsTheme: const PageTransitionsTheme(
                  builders: <TargetPlatform, PageTransitionsBuilder>{
                    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                    TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
                    TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
                    TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
                  })),
          backButtonDispatcher: backButtonDispatcher,
          routerDelegate: delegate,
          routeInformationParser: parser,
        ),
      ),
    );
  }
}