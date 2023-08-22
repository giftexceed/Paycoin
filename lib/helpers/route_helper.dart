import 'package:get/get.dart';
import 'package:paycoin/pages/home_page.dart';
import 'splash_page.dart';

class RouteHelper {
  static const String initial = "/";
  static const String splashPage = "/splash-page";

  static String getSplashPage() => splashPage;
  static String getInitial() => initial;

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => const SplashPage()),
    GetPage(name: initial, page: () => const HomePage()),
  ];
}
