import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wl_delivery/router/back_dispatcher.dart';
import 'package:wl_delivery/router/route_parser.dart';
import 'package:wl_delivery/router/router_delegate.dart';
import 'package:wl_delivery/router/ui_pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final delegate = AppRouterDelegate();
  final parser = RouteParser();
  MyBackButtonDispatcher backButtonDispatcher;

  // StreamSubscription _linkSubscription;

  _MyAppState() {
    delegate.setNewRoutePath(LoginPageConfig);
    backButtonDispatcher = MyBackButtonDispatcher(delegate);
    Get.put(delegate);
    // Get.put(CartHolder());
  }

  @override
  void initState() {
    super.initState();
    // initPlatformState();
  }
  //
  // @override
  // void dispose() {
  //   if (_linkSubscription != null) _linkSubscription.cancel();
  //   super.dispose();
  // }

  // Platform messages are asynchronous, so we initialize in an async method.
  // Future<void> initPlatformState() async {
  //   // Attach a listener to the Uri links stream
  //   _linkSubscription = getUriLinksStream().listen((Uri uri) {
  //     if (!mounted) return;
  //     setState(() {
  //       delegate.parseRoute(uri);
  //     });
  //   }, onError: (Object err) {
  //     print('Got error $err');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Navigation App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          pageTransitionsTheme: const PageTransitionsTheme(builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
            TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
          })
      ),
      backButtonDispatcher: backButtonDispatcher,
      routerDelegate: delegate,
      routeInformationParser: parser,
    );


    // return MaterialApp(
    //   title: 'Welcome to Flutter',
    //   theme: ThemeData(primaryColor: Colors.white),
    //   home: ListItems(),
    // );
  }
}