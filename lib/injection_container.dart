import 'package:localization_theme_mvc/features/general/services/general_repo.dart';

import 'core/network/network_info.dart';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/general/cubits/general_cubit.dart';
import 'features/general/services/general_local_data.dart';
import 'features/general/services/general_remote_data.dart';
import 'features/localization/presentation/cubits/localization_cubit.dart';
import 'features/theme/presentation/cubits/theme_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await initGeneral();
  await initLocalization();
  await initTheme();
}

Future<void> initGeneral() async {
//
//---------------------* General *-------------------------------
//! Features - General

//! Bloc

  sl.registerFactory(
      () => GeneralCubit(generalRemoteData: sl(), generalLocalData: sl()));

//! Use Cases

//! Repository
  sl.registerLazySingleton<GeneralRepo>(() => GeneralRepo(
      generalRemoteData: sl(), generalLocalData: sl(), networkInfo: sl()));
//! Data Sources
  sl.registerLazySingleton<GeneralRemoteData>(() => GeneralRemoteData());
  sl.registerLazySingleton<GeneralLocalData>(
    () => GeneralLocalData(
      sharedPreferences: sl(),
    ),
  );
//! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
//! External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() => InternetConnectionChecker());

  sl.registerLazySingleton(() => http.Client());
}

Future<void> initLocalization() async {
//
//---------------------* Localization *-------------------------------
//! Features - Localization

//! Bloc

  sl.registerFactory(() => LocalizationCubit(generalRepo: sl()));

//! Use Cases

//! Repository

//! Data Sources

//! Core

//! External

  // final sharedPreferences = await SharedPreferences.getInstance();
  // sl.registerLazySingleton(() => sharedPreferences);
}

Future<void> initTheme() async {
//
//---------------------* Theme *-------------------------------
//! Features - Theme

//! Bloc

  sl.registerFactory(() => ThemeCubit(generalRepo: sl()));

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
