import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_new/layout/cubit/cubit.dart';
import 'package:news_new/layout/cubit/states.dart';
import 'package:news_new/shared/components/news_card.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        if (state is NewsGetScienceLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemBuilder: (contex, index) {
              return NewsCard(
                newsModel: cubit.sNews[index],
              );
            },
            itemCount: cubit.sNews.length,
          );
        }
      },
    );
  }
}
