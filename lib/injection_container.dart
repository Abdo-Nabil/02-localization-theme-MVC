import 'package:waslny_user/features/theme/presentation/cubits/theme_cubit.dart';

import 'core/network/network_info.dart';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/localization/presentation/cubits/localization_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await initLocalization();
  await initTheme();
}

Future<void> initLocalization() async {
//
//---------------------* Localization *-------------------------------
//! Features - Localization

//! Bloc

  sl.registerFactory(() => LocalizationCubit(sharedPreferences: sl()));

//! Use Cases

//! Repository

//! Data Sources

//! Core

//! External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}

Future<void> initTheme() async {
//
//---------------------* Theme *-------------------------------
//! Features - Theme

//! Bloc

  sl.registerFactory(() => ThemeCubit(sharedPreferences: sl()));

//! Use Cases

//! Repository

//! Data Sources

//! Core

//! External

  //****** These lines have been implemented in Localization Feature ******
  // final sharedPreferences = await SharedPreferences.getInstance();
  // sl.registerLazySingleton(() => sharedPreferences);
}

//-----------------------------------------------------------------
//
// //! Features - posts
//
// // Bloc
//
//   sl.registerFactory(() => PostsBloc(getAllPosts: sl()));
//   sl.registerFactory(() => AddDeleteUpdatePostBloc(
//       addPost: sl(), updatePost: sl(), deletePost: sl()));
//
// // Usecases
//
//   sl.registerLazySingleton(() => GetAllPostsUsecase(sl()));
//   sl.registerLazySingleton(() => AddPostUsecase(sl()));
//   sl.registerLazySingleton(() => DeletePostUsecase(sl()));
//   sl.registerLazySingleton(() => UpdatePostUsecase(sl()));
//
// // Repository
//
//   sl.registerLazySingleton<PostsRepository>(() => PostsRepositoryImpl(
//       remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
//
// // Datasources
//
//   sl.registerLazySingleton<PostRemoteDataSource>(
//       () => PostRemoteDataSourceImpl(client: sl()));
//   sl.registerLazySingleton<PostLocalDataSource>(
//       () => PostLocalDataSourceImpl(sharedPreferences: sl()));
//
// //! Core
//
//   sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
//
// //! External
//
//   final sharedPreferences = await SharedPreferences.getInstance();
//   sl.registerLazySingleton(() => sharedPreferences);
//   sl.registerLazySingleton(() => http.Client());
//   sl.registerLazySingleton(() => InternetConnectionChecker());
