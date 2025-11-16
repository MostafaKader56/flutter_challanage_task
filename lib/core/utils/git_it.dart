import 'package:get_it/get_it.dart';
import 'package:task/features/auth/data/repo/auth_repo/auth_repo.dart';
import 'package:task/features/auth/data/repo/auth_repo/auth_repo_impl.dart';
import 'package:task/features/auth/data/repo/user_repo/user_repo.dart';
import 'package:task/features/auth/data/repo/user_repo/user_repo_impl.dart';
import 'package:task/features/home/data/repo/product_repo/product_repo_impl.dart';

import '../../features/home/data/repo/product_repo/product_repo.dart';

final getIt = GetIt.instance;

void setupDependencyInjection() {
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImpl());
  getIt.registerLazySingleton<UserRepo>(() => UserRepoImpl());
  getIt.registerLazySingleton<ProductRepo>(() => ProductRepoImpl());
}
