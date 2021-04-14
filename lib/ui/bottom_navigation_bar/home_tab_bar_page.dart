
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:wl_delivery/model/logic/cart.dart';
import 'package:wl_delivery/router/bloc_common/bloc_provider.dart';
import 'package:wl_delivery/router/router_delegate.dart';
import 'package:wl_delivery/ui/bottom_navigation_bar/home_tab_bar_cubit.dart';
import 'package:wl_delivery/ui/cart/user_cart/cart_bloc_context.dart';
import 'package:wl_delivery/ui/cart/user_cart/cart_cubit.dart';
import 'package:wl_delivery/ui/cart/user_cart/cart_sceen.dart';
import 'package:wl_delivery/ui/main/restaurants/main_bloc_context.dart';
import 'package:wl_delivery/ui/main/restaurants/main_cubit.dart';
import 'package:wl_delivery/ui/main/restaurants/main_screen.dart';
import 'package:wl_delivery/ui/orders/orders_bloc_context.dart';
import 'package:wl_delivery/ui/orders/orders_cubit.dart';
import 'package:wl_delivery/ui/orders/orders_screen.dart';
import 'package:wl_delivery/ui/profile/profile/profile.dart';
import 'package:wl_delivery/ui/profile/profile/profile_bloc_context.dart';
import 'package:wl_delivery/ui/profile/profile/profile_cubit.dart';

// Main Screen
class HomeTabBarPage extends StatefulWidget {

  final AppRouterDelegate routerDelegate;
  final cart = Get.find<Cart>();

  late final List<Widget> screens;

  HomeTabBarPage(this.routerDelegate) {
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
  _HomeTabBarPage createState() => _HomeTabBarPage();
}

class _HomeTabBarPage extends State<HomeTabBarPage> {

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            activeColor: Colors.red,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Main'),
              BottomNavigationBarItem(
                icon: BlocBuilder<HomeTabBarCubit, int>(builder: (context, state) {
                  return badgeIcon(Icon(Icons.shopping_cart_outlined), state);
                }) ,
                label: 'Cart',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.format_list_bulleted), label: 'Orders'),
              BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile')
            ],
          ),
          tabBuilder: (BuildContext context, index) {
            return widget.screens[index];
          }),
    );
  }

  Widget badgeIcon(Icon icon, int count) {
    if (count > 0) {
      return Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          icon,
          Positioned(
              top: 0,
              right: -10,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minWidth: 20, minHeight: 20),
                child: Container(
                  decoration: ShapeDecoration(
                      shape: StadiumBorder(),
                      color: Colors.red),
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Center(
                      child: Text(
                        count.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                ),
              ))
        ],
      );
    } else {
      return icon;
    }
  }
}