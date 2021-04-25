
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wl_delivery/ui/bottom_navigation_bar/home_tab_bar_cubit.dart';
import 'package:wl_delivery/ui/bottom_navigation_bar/home_tab_bar_page.dart';
import 'package:wl_delivery/ui/cart/checkout/checkout_bloc_context.dart';
import 'package:wl_delivery/ui/cart/checkout/checkout_cubit.dart';
import 'package:wl_delivery/ui/cart/checkout/checkout_sceen.dart';
import 'package:wl_delivery/ui/login/login.dart';
import 'package:wl_delivery/ui/login/login_bloc_context.dart';
import 'package:wl_delivery/ui/login/login_cubit.dart';
import 'package:wl_delivery/ui/profile/change_password/change_password.dart';
import 'package:wl_delivery/ui/profile/change_password/change_password_bloc_context.dart';
import 'package:wl_delivery/ui/profile/change_password/change_password_cubit.dart';
import 'package:wl_delivery/ui/profile/edit_profile/edit_profile.dart';
import 'package:wl_delivery/ui/profile/edit_profile/edit_profile_bloc_context.dart';
import 'package:wl_delivery/ui/profile/edit_profile/edit_profile_cubit.dart';
import 'package:wl_delivery/ui/signup/signup.dart';
import 'package:wl_delivery/ui/signup/signup_cubit.dart';
import 'package:wl_delivery/ui/splash.dart';
import 'bloc_common/bloc_provider.dart';
import 'ui_pages.dart';

class AppRouterDelegate extends RouterDelegate<PageConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfiguration> {

  // 3
  final List<MaterialPage> _pages = [];

  // 4
  @override
  PageConfiguration get currentConfiguration => _pages.last.arguments as PageConfiguration;

  // 5
  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  bool _onPopPage(Route<dynamic> route, result) {
    // 1
    final didPop = route.didPop(result);
    if (!didPop) {
      return false;
    }
    // 2
    _pages.remove(route.settings);
    // 3
    notifyListeners();

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _onPopPage,
      pages: List.of(_pages),
    );
  }

  void _removePage(MaterialPage page) {
    _pages.remove(page);
    notifyListeners();
  }

  @override
  Future<bool> popRoute() {
    if (_pages.length > 1) {
      _removePage(_pages.last);
      return Future.value(true);
    }
    return Future.value(false);
  }

  MaterialPage _createPage(Widget child, PageConfiguration pageConfig) {
    return MaterialPage(
        child: child,
        // key: ValueKey(pageConfig.key),
        name: pageConfig.path,
        arguments: pageConfig
    );
  }

  void _addPageData(Widget child, PageConfiguration pageConfig) {
    _pages.add(
      _createPage(child, pageConfig),
    );
  }
  //
  // void addPageRoute(Page page) {
  //   _pages.add(
  //       page
  //   );
  //   notifyListeners();
  // }

  void addPage(PageConfiguration pageConfig) {
    final shouldAddPage = _pages.isEmpty ||
        (_pages.last.arguments as PageConfiguration).uiPage !=
            pageConfig.uiPage;
    if (shouldAddPage) {
      switch (pageConfig.uiPage) {
        case Pages.Splash:
          _addPageData(
              Splash(), SplashPageConfig
          );
          break;
        case Pages.Login:
          _addPageData(
              BlocProviderObj(
                child: Login(),
                bloc: LoginCubit(),
                blocContext: LoginBlocContext(this),
              ),
              LoginPageConfig);
          break;
        case Pages.Signup:
          _addPageData(
              BlocProviderObj(
                child: Signup(),
                bloc: SignupCubit(),
                blocContext: SignupContextBase(),
              ),
              SignupPageConfig);
          break;
        case Pages.NavigationBar:
          _addPageData(BlocProvider(
            create: (_) => HomeTabBarCubit(),
            child: HomeTabBarPage(this),
          ), NavigationBarPageConfig);
          break;
        case Pages.EditProfile:
          _addPageData(
              BlocProviderObj(
                child: EditProfile(),
                bloc: EditProfileCubit('', ''),
                blocContext: EditProfileContext(this),
              ),
              EditProfilePageConfig);
          break;
        case Pages.ChangePassword:
          _addPageData(
              BlocProviderObj(
                child: ChangePassword(),
                bloc: ChangePasswordCubit(),
                blocContext: ChangePasswordContext(this),
              ),
              ChangePasswordPageConfig);
          break;
        case Pages.Products:
          _addPageData(
              BlocProviderObj(
                child: ChangePassword(),
                bloc: ChangePasswordCubit(),
                blocContext: ChangePasswordContext(this),
              ),
              ChangePasswordPageConfig);
          break;

        case Pages.Checkout:
          _addPageData(
              BlocProviderObj(
                child: CheckoutScreen(),
                bloc: CheckoutCubit(),
                blocContext: CheckoutBlocContext(this),
              ),
              ChangePasswordPageConfig);
          break;
        // case Pages.SearchAddress:
        //   _addPageData(
        //     BlocProvider(
        //         create: (_) => SearchAddressCubit(),
        //         child: SearchAddressPage()
        //     ),
        //       ChangePasswordPageConfig
        //   );
        //   break;

        default:
          break;
      }
      notifyListeners();
    }
  }

  void replace(PageConfiguration newRoute) {
    if (_pages.isNotEmpty) {
      _pages.removeLast();
    }
    addPage(newRoute);
  }

  void setPath(List<MaterialPage> path) {
    _pages.clear();
    _pages.addAll(path);
    notifyListeners();
  }

  void replaceAll(PageConfiguration newRoute) {
    setNewRoutePath(newRoute);
  }

  void push(PageConfiguration newRoute) {
    addPage(newRoute);
  }

  void pushWidget(Widget child, PageConfiguration newRoute) {
    _addPageData(child, newRoute);
    notifyListeners();
  }

  @override
  Future<void> setNewRoutePath(PageConfiguration configuration) {
    _pages.clear();
    addPage(configuration);
    return SynchronousFuture(null);
  }

  MaterialPage _getPage(Pages routeName) {
    return _pages.lastWhere((element) =>
    (element.arguments as PageConfiguration).uiPage == routeName);
  }
  //
  // void parseRoute(Uri uri) {
  //   if (uri.pathSegments.isEmpty) {
  //     setNewRoutePath(SplashPageConfig);
  //     return;
  //   }
  //
  //   // Handle navapp://deeplinks/details/#
  //   if (uri.pathSegments.length == 2) {
  //     if (uri.pathSegments[0] == 'details') {
  //       pushWidget(Details(int.parse(uri.pathSegments[1])), DetailsPageConfig);
  //     }
  //   } else if (uri.pathSegments.length == 1) {
  //     final path = uri.pathSegments[0];
  //     switch (path) {
  //       case 'splash':
  //         replaceAll(SplashPageConfig);
  //         break;
  //       case 'login':
  //         replaceAll(LoginPageConfig);
  //         break;
  //       case 'createAccount':
  //         setPath([
  //           _createPage(Login(), LoginPageConfig),
  //           _createPage(CreateAccount(), CreateAccountPageConfig)
  //         ]);
  //         break;
  //       case 'listItems':
  //         replaceAll(ListItemsPageConfig);
  //         break;
  //       case 'cart':
  //         setPath([
  //           _createPage(ListItems(), ListItemsPageConfig),
  //           _createPage(Cart(), CartPageConfig)
  //         ]);
  //         break;
  //       case 'checkout':
  //         setPath([
  //           _createPage(ListItems(), ListItemsPageConfig),
  //           _createPage(Checkout(), CheckoutPageConfig)
  //         ]);
  //         break;
  //       case 'settings':
  //         setPath([
  //           _createPage(ListItems(), ListItemsPageConfig),
  //           _createPage(Settings(), SettingsPageConfig)
  //         ]);
  //         break;
  //     }
  //   }
  // }

  void remove(Pages routeName) {
    _removePage(_getPage(routeName));
  }

}

class CupertinoModalBottomSheetPage<T> extends MaterialPage<T> {

  CupertinoModalBottomSheetPage({child: Widget, required LocalKey key, String? name, Object? arguments}) : super(child: child, key: key, name: name, arguments: arguments);

  @override
  Route<T> createRoute(BuildContext context) {
    return CupertinoModalBottomSheetRoute<T>(
        builder: (context) => child,
        containerBuilder: (context, _, child) => _CupertinoBottomSheetContainer(
          child: child,
          // backgroundColor: backgroundColor,
          topRadius:  Radius.circular(12),
          // shadow: shadow,
        ),
        // secondAnimationController: secondAnimation,
        expanded: false,
        // closeProgressThreshold: closeProgressThreshold,
        barrierLabel: '',
        // elevation: elevation,
        // bounce: bounce,
        // shape: shape,
        // clipBehavior: clipBehavior,
        isDismissible: true,
        modalBarrierColor: Colors.black12,
        enableDrag: true,
        // topRadius: topRadius,
        // animationCurve: animationCurve,
        // previousRouteAnimationCurve: previousRouteAnimationCurve,
        // duration: duration,
        // settings: settings,
        transitionBackgroundColor: Colors.black);
  }
}

class _CupertinoBottomSheetContainer extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final Radius topRadius;
  final BoxShadow? shadow;

  const _CupertinoBottomSheetContainer({
    Key? key,
    required this.child,
    this.backgroundColor,
    required this.topRadius,
    this.shadow,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final topSafeAreaPadding = MediaQuery.of(context).padding.top;
    final topPadding = 10 + topSafeAreaPadding;

    final _shadow = shadow ?? BoxShadow(blurRadius: 10, color: Colors.black12, spreadRadius: 5);
    BoxShadow(blurRadius: 10, color: Colors.black12, spreadRadius: 5);
    final _backgroundColor =
        backgroundColor ?? CupertinoTheme.of(context).scaffoldBackgroundColor;
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: topRadius),
        child: Container(
          decoration:
          BoxDecoration(color: _backgroundColor, boxShadow: [_shadow]),
          width: double.infinity,
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true, //Remove top Safe Area
            child: child,
          ),
        ),
      ),
    );
  }
}
