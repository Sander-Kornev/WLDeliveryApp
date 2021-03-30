
import 'package:flutter/material.dart';
import 'ui_pages.dart';

class RouteParser extends RouteInformationParser<PageConfiguration> {
  @override
  Future<PageConfiguration> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);
    if (uri.pathSegments.isEmpty) {
      return LoginPageConfig;
    }

    final path = uri.pathSegments[0];
    switch (path) {
      case SplashPath:
        return SplashPageConfig;
      case LoginPath:
        return LoginPageConfig;
      case SignupPath:
        return SignupPageConfig;
      case NavigationBarPath:
        return NavigationBarPageConfig;
      case EditProfilePath:
        return EditProfilePageConfig;
      case ChangePasswordPath:
        return ChangePasswordPageConfig;
      case CheckoutPath:
        return CheckoutPageConfig;
      case SettingsPath:
        return SettingsPageConfig;
      default:
        return SplashPageConfig;
    }
  }

  @override
  RouteInformation restoreRouteInformation(PageConfiguration configuration) {
    switch (configuration.uiPage) {
      case Pages.Splash:
        return const RouteInformation(location: SplashPath);
      case Pages.Login:
        return const RouteInformation(location: LoginPath);
      case Pages.Signup:
        return const RouteInformation(location: SignupPath);
      case Pages.NavigationBar:
        return const RouteInformation(location: NavigationBarPath);
      case Pages.EditProfile:
        return const RouteInformation(location: EditProfilePath);
      case Pages.ChangePassword:
        return const RouteInformation(location: ChangePasswordPath);
      case Pages.Checkout:
        return const RouteInformation(location: CheckoutPath);
      case Pages.Settings:
        return const RouteInformation(location: SettingsPath);
      default: return const RouteInformation(location: SplashPath);

    }
  }
}