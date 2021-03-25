
const String SplashPath = '/splash';
const String LoginPath = '/login';
const String SignupPath = '/signup';
const String NavigationBarPath = '/navigationBar';
const String DetailsPath = '/details';
const String CartPath = '/cart';
const String CheckoutPath = '/checkout';
const String SettingsPath = '/settings';

enum Pages {
  Splash,
  Login,
  Signup,
  NavigationBar,
  Details,
  Cart,
  Checkout,
  Settings
}

class PageConfiguration {
  final String key;
  final String path;
  final Pages uiPage;

  const PageConfiguration(
      {required this.key, required this.path, required this.uiPage});
}

const PageConfiguration SplashPageConfig =
    PageConfiguration(key: 'Splash', path: SplashPath, uiPage: Pages.Splash);
const PageConfiguration LoginPageConfig =
    PageConfiguration(key: 'Login', path: LoginPath, uiPage: Pages.Login);
const PageConfiguration SignupPageConfig = PageConfiguration(
    key: 'Signup', path: SignupPath, uiPage: Pages.Signup);
const PageConfiguration NavigationBarPageConfig = PageConfiguration(
    key: 'NavigationBar', path: NavigationBarPath, uiPage: Pages.NavigationBar);

const PageConfiguration DetailsPageConfig =
    PageConfiguration(key: 'Details', path: DetailsPath, uiPage: Pages.Details);
const PageConfiguration CartPageConfig =
    PageConfiguration(key: 'Cart', path: CartPath, uiPage: Pages.Cart);
const PageConfiguration CheckoutPageConfig = PageConfiguration(
    key: 'Checkout', path: CheckoutPath, uiPage: Pages.Checkout);
const PageConfiguration SettingsPageConfig = PageConfiguration(
    key: 'Settings', path: SettingsPath, uiPage: Pages.Settings);
