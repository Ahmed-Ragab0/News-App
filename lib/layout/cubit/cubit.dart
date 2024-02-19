import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_new/layout/cubit/states.dart';
import 'package:news_new/modules/business/business_screen.dart';
import 'package:news_new/modules/science/science_screen.dart';
import 'package:news_new/modules/settings_screen/setting_screen.dart';
import 'package:news_new/modules/sports/sports_screen.dart';
import 'package:news_new/network/local/cach_helper.dart';

import 'package:news_new/shared/themes/app_theme.dart';

import '../../models/news_model.dart';
import '../../network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialStat());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.business_center),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports_baseball),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science_rounded),
      label: 'Science',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];

  List<Widget> screens = const [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingsScreen(),
  ];

  void changeBottomNavBar(index) {
    currentIndex = index;
    emit(NewsBottomNavState());
  }

  List<dynamic> data = [];

  List<NewsModel> bNews = [];
  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'us',
        'category': 'business',
        'apiKey': 'deaeb3ccf96b48fc95a4a424341dc892',
      },
    ).then((value) {
      //print(value?.data['articles'][0]['title'],);

      data = value?.data['articles'];
      for (int i = 0; i < data.length; i++) {
        bNews.add(NewsModel.fromJson(data[i]));
      }
      //print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<NewsModel> sNews = [];
  void getScience() {
    emit(NewsGetScienceLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'us',
        'category': 'science',
        'apiKey': 'deaeb3ccf96b48fc95a4a424341dc892',
      },
    ).then((value) {
      //print(value?.data['articles'][0]['title'],);

      data = value?.data['articles'];
      for (int i = 0; i < data.length; i++) {
        sNews.add(NewsModel.fromJson(data[i]));
      }
      //print(business[0]['title']);
      emit(NewsGetScienceSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetScienceErrorState(error.toString()));
    });
  }

  List<NewsModel> spNews = [];
  void getSport() {
    emit(NewsGetSportsLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'us',
        'category': 'sports',
        'apiKey': 'deaeb3ccf96b48fc95a4a424341dc892',
      },
    ).then((value) {
      //print(value?.data['articles'][0]['title'],);

      data = value?.data['articles'];
      for (int i = 0; i < data.length; i++) {
        spNews.add(NewsModel.fromJson(data[i]));
      }
      //print(business[0]['title']);
      emit(NewsGetSportsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSportsErrorState(error.toString()));
    });
  }

  List<NewsModel> search = [];

  void getSearch(String value) {
    search = [];
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': value,
        'apiKey': 'deaeb3ccf96b48fc95a4a424341dc892',
      },
    ).then((value) {
      //print(value?.data['articles'][0]['title'],);

      data = value?.data['articles'];
      for (int i = 0; i < data.length; i++) {
        search.add(NewsModel.fromJson(data[i]));
      }
      //print(business[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(AppTheme.lightTheme);

  static ThemeCubit get(context) => BlocProvider.of(context);

  void changeThemeApp({bool? fromShared}) {
    fromShared ??= true;
    if (fromShared == false) {
      emit(AppTheme.darkTheme);
    } else if (fromShared == true) {
      emit(AppTheme.lightTheme);
    }
    // Save the theme state in SharedPreferences
    CachHelper.putData(key: 'themeMode', value: fromShared);
  }
}
