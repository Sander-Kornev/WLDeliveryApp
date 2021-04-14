
const String SplashPath = '/splash';
const String LoginPath = '/login';
const String SignupPath = '/signup';
const String NavigationBarPath = '/navigationBar';
const String EditProfilePath = '/editProfile';
const String ChangePasswordPath = '/changePassword';
const String SettingsPath = '/settings';

const String CategoriesPath = '/categories';
const String ProductsPath = '/products';
const String CheckoutPath = '/checkout';

enum Pages {
  Splash,
  Login,
  Signup,
  NavigationBar,
  EditProfile,
  ChangePassword,
  Settings,

  Categories,
  Products,
  Checkout
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
const PageConfiguration EditProfilePageConfig =
    PageConfiguration(key: 'Edit Profile', path: EditProfilePath, uiPage: Pages.EditProfile);
const PageConfiguration ChangePasswordPageConfig =
    PageConfiguration(key: 'Change Password', path: ChangePasswordPath, uiPage: Pages.ChangePassword);
const PageConfiguration SettingsPageConfig = PageConfiguration(
    key: 'Settings', path: SettingsPath, uiPage: Pages.Settings);

const PageConfiguration CategoriesPageConfig = PageConfiguration(
    key: 'Categories', path: CategoriesPath, uiPage: Pages.Categories);
const PageConfiguration ProductsPageConfig = PageConfiguration(
    key: 'Products', path: ProductsPath, uiPage: Pages.Products);
const PageConfiguration CheckoutPageConfig = PageConfiguration(
    key: 'Checkout', path: CheckoutPath, uiPage: Pages.Checkout);
