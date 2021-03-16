
import 'package:flutter/material.dart';
import 'router_delegate.dart';

class MyBackButtonDispatcher extends RootBackButtonDispatcher {
  final AppRouterDelegate _routerDelegate;

  MyBackButtonDispatcher(this._routerDelegate)
      : super();

  @override
  Future<bool> didPopRoute() {
    return _routerDelegate.popRoute();
  }
}
