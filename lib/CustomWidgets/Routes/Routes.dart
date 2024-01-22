import 'package:go_router/go_router.dart';
import 'package:playspot_client/Screens/BookingScreen/Ui/BookingScreen.dart';
import 'package:playspot_client/Screens/Home/Ui/HomeScreen.dart';
import 'package:playspot_client/Screens/MybookingScreen/Ui/MybookingScreen.dart';
import 'package:playspot_client/Screens/SplashScreen/Ui/SplashScreen.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
        name: "home",
        path: "/home",
        builder: ((context, state) => HomeScreen())),
    GoRoute(
       name: "mybooking",
      path: "/mybooking",
      builder: (context, state) => MybookingScreen(),
    )
  ]);
}
