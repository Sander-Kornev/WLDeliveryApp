
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wl_delivery/router/bloc_common/bloc_provider.dart';
import 'package:wl_delivery/router/router_delegate.dart';
import 'package:wl_delivery/ui/cart/cart_bloc_context.dart';
import 'package:wl_delivery/ui/cart/cart_cubit.dart';
import 'package:wl_delivery/ui/cart/cart_sceen.dart';
import 'package:wl_delivery/ui/main/main_bloc_context.dart';
import 'package:wl_delivery/ui/main/main_cubit.dart';
import 'package:wl_delivery/ui/main/main_screen.dart';
import 'package:wl_delivery/ui/orders/orders_bloc_context.dart';
import 'package:wl_delivery/ui/orders/orders_cubit.dart';
import 'package:wl_delivery/ui/orders/orders_screen.dart';
import 'package:wl_delivery/ui/profile/profile/profile.dart';
import 'package:wl_delivery/ui/profile/profile/profile_bloc_context.dart';
import 'package:wl_delivery/ui/profile/profile/profile_cubit.dart';

// Main Screen
class MyHomePage extends StatefulWidget {

  final AppRouterDelegate routerDelegate;

  late List<Widget> screens;

  MyHomePage(this.routerDelegate) {
    screens = [
      BlocProviderObj(
          child: MainScreen(),
          bloc: MainCubit(),
          blocContext: MainBlocContext(routerDelegate)),
      BlocProviderObj(
          child: CartScreen(),
          bloc: CartCubit(),
          blocContext: CartBlocContext(routerDelegate)),
      BlocProviderObj(
          child: OrdersScreen(),
          bloc: OrdersCubit(),
          blocContext: OrdersBlocContext(routerDelegate)),
      BlocProviderObj(
          child: Profile(),
          bloc: ProfileCubit(),
          blocContext: ProfileBlocContext(routerDelegate)),
    ];
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            activeColor: Colors.red,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Main'),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
              BottomNavigationBarItem(icon: Icon(Icons.format_list_bulleted), label: 'Orders'),
              BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile')
            ],
          ),
          tabBuilder: (BuildContext context, index) {
            return widget.screens[index];
          }),
    );
  }
}