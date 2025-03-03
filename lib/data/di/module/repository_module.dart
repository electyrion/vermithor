import 'dart:async';

import 'package:vermithor/data/local/datasources/post/post_datasource.dart';
import 'package:vermithor/data/network/apis/posts/post_api.dart';
import 'package:vermithor/data/repository/post/post_repository_impl.dart';
import 'package:vermithor/data/repository/setting/setting_repository_impl.dart';
import 'package:vermithor/data/repository/user/user_repository_impl.dart';
import 'package:vermithor/data/sharedpref/shared_preference_helper.dart';
import 'package:vermithor/domain/repository/post/post_repository.dart';
import 'package:vermithor/domain/repository/setting/setting_repository.dart';
import 'package:vermithor/domain/repository/user/user_repository.dart';

import '../../../di/service_locator.dart';

mixin RepositoryModule {
  static Future<void> configureRepositoryModuleInjection() async {
    // repository:--------------------------------------------------------------
    getIt.registerSingleton<SettingRepository>(SettingRepositoryImpl(
      getIt<SharedPreferenceHelper>(),
    ));

    getIt.registerSingleton<UserRepository>(UserRepositoryImpl(
      getIt<SharedPreferenceHelper>(),
    ));

    getIt.registerSingleton<PostRepository>(PostRepositoryImpl(
      getIt<PostApi>(),
      getIt<PostDataSource>(),
    ));
  }
}
