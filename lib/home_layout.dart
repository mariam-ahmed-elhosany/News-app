import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app_cubit/cubit.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/state.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'package:news_app/screens/search.dart';
class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        NewsCubit cubit=BlocProvider.of(context);
        return  Scaffold(
          appBar: AppBar(
            title: Text('News App',),
            actions: [
              IconButton(onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>SearchScreen()));
              }, icon: Icon(Icons.search),),
              IconButton(onPressed: (){
                 AppCubit.get(context).changeAppMode();
              }, icon: Icon(Icons.brightness_2_outlined),),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.items,
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottomNavBar(index);
            },

          ),
        );
      },
    );
  }
}
