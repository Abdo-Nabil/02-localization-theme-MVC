import 'package:dartz/dartz.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../../core/network/network_info.dart';
import 'general_local_data.dart';
import 'general_remote_data.dart';

class GeneralRepo {
  final GeneralRemoteData generalRemoteData;
  final GeneralLocalData generalLocalData;
  final NetworkInfo networkInfo;

  GeneralRepo({
    required this.generalRemoteData,
    required this.generalLocalData,
    required this.networkInfo,
  });

  //-------------General local data--------------------
  String? getString(String key) {
    final String? result = generalLocalData.getString(key);
    return result;
  }

  Future<Either<Failure, Unit>> setString(String key, String value) async {
    try {
      await generalLocalData.setString(key, value);
      return Future.value(const Right(unit));
    } on CacheSavingException {
      return Left(CacheSavingFailure());
    }
  }

  bool? getBool(String key) {
    final bool? result = generalLocalData.getBool(key);
    return result;
  }

  Future<Either<Failure, Unit>> setBool(String key, bool value) async {
    try {
      await generalLocalData.setBool(key, value);
      return Future.value(const Right(unit));
    } on CacheSavingException {
      return Left(CacheSavingFailure());
    }
  }

  Future<Either<Failure, Unit>> removeKey(String key) async {
    try {
      await generalLocalData.removeKey(key);
      return Future.value(const Right(unit));
    } on CacheRemovingException {
      return Left(CacheRemovingFailure());
    }
  }

/*
 Future<String> getAppVersion() async {
    String result = await generalLocalData.getAppVersion();
    return result;
  }
*/

/*
  static Future<void> launchLink(String url, BuildContext context) async {
    final Uri link = Uri.parse(url);
    if (await canLaunchUrl(link)) {
      await launchUrl(link);
    } else {
      if (context.mounted) {
        ToastHelper.showToast(
            context, AppStrings.canotLaunch.tr(context), ToastStates.error);
        throw 'Could not launch $url';
      }
    }
  }
*/

//-------------General remote data--------------------
/*
  Future<Either<Failure, UserModel>> getUserData() async {
    //
    if (await networkInfo.isConnected) {
      try {
        final UserModel uData = await generalRemoteData.getUserData();
        userData = uData;
        return Right(userData);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
    //
  }
*/

/*
  Future<Either<Failure, String>> fetchBuildNumber() async {
    //
    if (await networkInfo.isConnected) {
      try {
        final String buildNumber = await generalRemoteData.fetchBuildNumber();
        return Right(buildNumber);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
    //
  }
*/
}
