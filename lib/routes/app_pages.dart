import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/route_manager.dart';
import 'package:presence_27_maret/controller/all_presence_controller.dart';
import 'package:presence_27_maret/pages/all_presence_page.dart';
import 'package:presence_27_maret/pages/detail_presence_page.dart';
import 'package:presence_27_maret/pages/login.dart';
import 'package:presence_27_maret/pages/lupa_password.dart';
import 'package:presence_27_maret/pages/new_password.dart';
import 'package:presence_27_maret/pages/profile.dart';
import 'package:presence_27_maret/pages/update_password.dart';
import 'package:presence_27_maret/pages/update_profile_page.dart';

import '../pages/home.dart';
import '../pages/pegawai.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // static const INITIAL = AppRoutes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomePage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.PASSWORD,
      page: () => PasswordPage(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginPage(),
    ),
    GetPage(
      name: _Paths.ADD_PEGAWAI,
      page: () => PegawaiPage(),
    ),
    GetPage(
      name: _Paths.LUPA_PASSWORD,
      page: () => LupaPassword(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfilePage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.UPDATE_PROFILE,
      page: () => UpdateProfilePage(),
    ),
    GetPage(
      name: _Paths.UPDATE_PASSWORD,
      page: () => UpdatePasswordPage(),
    ),
    GetPage(
      name: _Paths.DETAIL_PRESENCE,
      page: () => DetailPresencePage(),
    ),
    GetPage(
      name: _Paths.ALL_PRESENCE,
      page: () => AllPresencePage(),
    ),
  ];
}
