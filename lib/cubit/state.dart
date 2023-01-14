abstract class NewsStates{}
class InitialState extends NewsStates{}
class BottomNavBarState extends NewsStates{}
class GetBusinessDataSuccessState extends NewsStates{}
class GetBusinessDataErrorState extends NewsStates{
   String? error;
   GetBusinessDataErrorState(this.error);
}
class NewsLoadingGetBusinessDataSuccessState extends NewsStates{}

class GetSportsDataSuccessState extends NewsStates{}
class GetSportsDataErrorState extends NewsStates{
   String? error;
   GetSportsDataErrorState(this.error);
}
class NewsLoadingGetSportsDataSuccessState extends NewsStates{}

class GetScienceDataSuccessState extends NewsStates{}
class GetScienceDataErrorState extends NewsStates{
   String? error;
   GetScienceDataErrorState(this.error);
}
class NewsLoadingGetScienceDataSuccessState extends NewsStates{}

class GetSearchDataSuccessState extends NewsStates{}
class GetSearchDataErrorState extends NewsStates{
   String? error;
   GetSearchDataErrorState(this.error);
}
class NewsLoadingGetSearchDataSuccessState extends NewsStates{}