import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_new/layout/cubit/cubit.dart';
import 'package:news_new/layout/cubit/states.dart';
import 'package:news_new/shared/components/news_card.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, NewsStates>(
      //listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        if (cubit.bNews.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemBuilder: (contex, index) {
              return NewsCard(
                newsModel: cubit.bNews[index],
              );
            },
            itemCount: cubit.bNews.length,
          );
        }
      },
    );
  }
}
