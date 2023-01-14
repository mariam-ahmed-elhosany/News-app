// ignore_for_file: unnecessary_string_interpolations

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:news_app/app_cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/network/local/shared_preferences.dart';


class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState());

  static AppCubit get(context) => BlocProvider.of(context);
  bool isDark=false;

  changeAppMode({bool? appModeFromShared}){
    if(appModeFromShared !=null)
      {
        isDark=appModeFromShared;
      }
    else {
      isDark = !isDark;
      CashHelper.setData(key: 'isDark', value: isDark).then((value) {
        emit(ChangeAppMode());
      });

    }
  }

}
