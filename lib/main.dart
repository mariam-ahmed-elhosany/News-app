// ignore_for_file: prefer_const_constructors

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/app_cubit/cubit.dart';
import 'package:news_app/app_cubit/states.dart';
import 'package:news_app/bloc_observer.dart';
import 'package:news_app/network/local/shared_preferences.dart';
import 'package:news_app/network/remote/dio_helper.dart';

import 'cubit/cubit.dart';
import 'home_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CashHelper.init();
  bool? isDark = CashHelper.getData(key: 'isDark');
  runApp(MyApp(isDark));
  Bloc.observer = MyBlocObserver();
}

class MyApp extends StatelessWidget {
  final bool? isDark;

  MyApp(this.isDark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) =>
              AppCubit()..changeAppMode(appModeFromShared: isDark),),
        BlocProvider(create: (BuildContext context) => NewsCubit()..getBusinessData(),)
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.green,
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                elevation: 2.0,
                selectedItemColor: Colors.green,
              ),
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                actionsIconTheme: IconThemeData(color: Colors.black),
                backgroundColor: Colors.white,
                elevation: 0,
                titleTextStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.green,
                    statusBarBrightness: Brightness.dark),
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            darkTheme: ThemeData(
              dividerTheme: DividerThemeData(color: Colors.white),
              appBarTheme: AppBarTheme(
                actionsIconTheme: IconThemeData(color: Colors.white),
                backgroundColor: HexColor('333739'),
                elevation: 0,
                titleTextStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.green,
                    statusBarBrightness: Brightness.light),
              ),
              primarySwatch: Colors.green,
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  elevation: 2.0,
                  selectedItemColor: Colors.green,
                  unselectedItemColor: Colors.grey,
                  backgroundColor: HexColor('333739')),
              scaffoldBackgroundColor: HexColor('333739'),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            home: Directionality(
                textDirection: TextDirection.ltr, child: HomeLayout()),
          );
        },
      ),
    );
  }
}
