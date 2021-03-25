
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wl_delivery/ui/bottom_navigation_bar/my_navigation_bar.dart';
import 'package:wl_delivery/ui/login/login.dart';
import 'package:wl_delivery/ui/login/login_bloc_context.dart';
import 'package:wl_delivery/ui/login/login_cubit.dart';
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
        // key: Key(pageConfig.key),
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
              Splash(),
              SplashPageConfig
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
              LoginPageConfig);
          break;
        case Pages.NavigationBar:
          _addPageData(MyNavigationBar(Key("key")), NavigationBarPageConfig);
          break;
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
