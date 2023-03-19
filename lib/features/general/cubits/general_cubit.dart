import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/general_local_data.dart';
import '../services/general_remote_data.dart';
import 'general_state.dart';

class GeneralCubit extends Cubit<GeneralState> {
  final GeneralLocalData generalLocalData;
  final GeneralRemoteData generalRemoteData;
  GeneralCubit(
      {required this.generalLocalData, required this.generalRemoteData})
      : super(GeneralInitial());

  static GeneralCubit getIns(BuildContext context) {
    return BlocProvider.of<GeneralCubit>(context);
  }

  late Widget selectedScreen;

/*
  getInitialScreen() {
    final String? result = generalLocalData.getString(AppStrings.storedRoute);
    if (result == null) {
      selectedScreen = const OnBoardingScreen();
    }
    //
    else {
      final String? token = generalLocalData.getString(AppStrings.storedToken);
      if (token == null) {
        selectedScreen = const LoginScreen();
      } else {
        selectedScreen = const HomeScreen();
      }
    }
  }
*/

/*
  Future setInitialScreen(String routeName) async {
    await generalLocalData.setString(
      AppStrings.storedRoute,
      routeName,
    );
  }
*/
}
