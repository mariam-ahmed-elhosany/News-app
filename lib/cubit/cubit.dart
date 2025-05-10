import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:news_app/screens/business.dart';
import 'package:news_app/screens/science.dart';
import 'package:news_app/screens/search.dart';
import 'package:news_app/screens/sports.dart';

import '../network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit():super(InitialState());
  static NewsCubit get(context)=>BlocProvider.of(context);
  int currentIndex=0;
  List<Widget> screens=[
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];
  List<BottomNavigationBarItem>items=[
    BottomNavigationBarItem(icon: Icon(Icons.business),label: "Business",),
    BottomNavigationBarItem(icon: Icon(Icons.sports),label: "Sports",),
    BottomNavigationBarItem(icon: Icon(Icons.science),label: "Science",),
  ];
  void changeBottomNavBar(int index){
    currentIndex=index;
    if(index==1){
      getSportsData();
    }
    if(index==2){
      getScienceData();
    }

    emit(BottomNavBarState());
  }
  List<dynamic>businessData=[];
  void getBusinessData(){
    emit(NewsLoadingGetBusinessDataSuccessState());
    if(businessData.length==0){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'business',
            'apiKey':'0d2fc4df1ae64d528e442a414607ee81',
          }).then((value) {
        businessData=value.data['articles'];
        print(businessData[0]['title']);
        emit(GetBusinessDataSuccessState());
      }).catchError((error){
        print("Error when getting date ${error.toString()}");
        emit(GetBusinessDataErrorState(error));
      });
    }
    else
      emit(GetBusinessDataSuccessState());
  }

  List<dynamic>sportsData=[];
  void getSportsData(){
    emit(NewsLoadingGetSportsDataSuccessState());
    if(sportsData.length==0){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'sports',
            'apiKey':'0d2fc4df1ae64d528e442a414607ee81',
          }).then((value) {
        sportsData=value.data['articles'];
        print(sportsData[0]['title']);
        emit(GetSportsDataSuccessState());
      }).catchError((error){
        print("Error when getting date ${error.toString()}");
        emit(GetSportsDataErrorState(error));
      });
    }
    else
      emit(GetSportsDataSuccessState());
  }

  List<dynamic>scienceData=[];
  void getScienceData() {
    emit(NewsLoadingGetScienceDataSuccessState());
    if(scienceData.length==0){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'science',
            'apiKey':'0d2fc4df1ae64d528e442a414607ee81',
          }).then((value) {
        scienceData=value.data['articles'];
        print(scienceData[0]['title']);
        emit(GetScienceDataSuccessState());
      }).catchError((error){
        print("Error when getting data ${error.toString()}");
        emit(GetScienceDataErrorState(error));
      });
    }
    else
      emit(GetScienceDataSuccessState());
  }
  List<dynamic>searchData=[];
  void getSearchData(String value) {
    emit(NewsLoadingGetScienceDataSuccessState());

    DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q':'$value',
          'apiKey':'0d2fc4df1ae64d528e442a414607ee81',
        }).then((value) {
      searchData=value.data['articles'];
      print(searchData[0]['title']);
      emit(GetSearchDataSuccessState());
    }).catchError((error){
      print("Error when getting data ${error.toString()}");
      emit(GetSearchDataErrorState(error));
    });
  }
}