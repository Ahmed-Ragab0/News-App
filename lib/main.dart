import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_new/layout/cubit/cubit.dart';
import 'package:news_new/network/local/cach_helper.dart';
import 'package:news_new/network/remote/dio_helper.dart';
import 'package:news_new/shared/bloc_observer.dart';
import 'layout/news_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CachHelper.init();
  runApp(const Newsy());
}

class Newsy extends StatelessWidget {
  const Newsy({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit(),
        ),
        BlocProvider(
          create: (context) => ThemeCubit()
            ..changeThemeApp(
                fromShared: CachHelper.getData(key: 'themeMode') ?? true),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: state,
            home: const NewsLayout(),
          );
        },
      ),
    );
  }
}
