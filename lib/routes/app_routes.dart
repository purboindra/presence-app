part of 'app_pages.dart';

abstract class AppRoutes {
  AppRoutes._();

  static const HOME = _Paths.HOME;
  static const ADD_PEGAWAI = _Paths.ADD_PEGAWAI;
  static const LOGIN = _Paths.LOGIN;
  static const PASSWORD = _Paths.PASSWORD;
  static const LUPA_PASSWORD = _Paths.LUPA_PASSWORD;
  static const PROFILE = _Paths.PROFILE;
  static const UPDATE_PROFILE = _Paths.UPDATE_PROFILE;
  static const UPDATE_PASSWORD = _Paths.UPDATE_PASSWORD;
  static const DETAIL_PRESENCE = _Paths.DETAIL_PRESENCE;
  static const ALL_PRESENCE = _Paths.ALL_PRESENCE;
}

abstract class _Paths {
  static const HOME = '/home';
  static const PASSWORD = '/password';
  static const ADD_PEGAWAI = "/pegawai";
  static const LOGIN = "/login";
  static const LUPA_PASSWORD = "/lupa_password";
  static const PROFILE = "/profile";
  static const UPDATE_PROFILE = '/update_profile';
  static const UPDATE_PASSWORD = '/update_password';
  static const DETAIL_PRESENCE = '/detail_presence';
  static const ALL_PRESENCE = '/all_presence';
}
