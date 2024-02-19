import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_new/layout/cubit/cubit.dart';
import 'package:news_new/layout/cubit/states.dart';
import 'package:news_new/modules/search/search_screen.dart';
import 'package:news_new/network/local/cach_helper.dart';
import 'package:news_new/shared/components/navigate_to.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()
        ..getBusiness()
        ..getSport()
        ..getScience(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NewsCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'News App',
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    NavigateTo(context, Searchscreen());
                  },
                  icon: const Icon(Icons.search),
                ),
                IconButton(
                  onPressed: () {
                    bool? fromShared = CachHelper.getData(key: 'themeMode');
                    if (fromShared == true) {
                      fromShared = false;
                      var themeCubit = ThemeCubit.get(context);
                      themeCubit.changeThemeApp(fromShared: fromShared);
                      print(fromShared);
                    } else if (fromShared == false) {
                      fromShared = true;
                      var themeCubit = ThemeCubit.get(context);
                      themeCubit.changeThemeApp(fromShared: fromShared);
                      print(fromShared);
                    }
                  },
                  icon: const Icon(Icons.brightness_4_outlined),
                )
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            extendBody: true,
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BottomNavigationBar(
                  elevation: 20,
                  currentIndex: cubit.currentIndex,
                  onTap: (index) {
                    cubit.changeBottomNavBar(index);
                  },
                  items: cubit.bottomItems,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
