import 'package:flutter/material.dart';
import 'package:news_new/models/news_model.dart';
import 'package:news_new/modules/web_view/web_view_screen.dart';
import 'package:news_new/shared/components/navigate_to.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    super.key,
    required this.newsModel,
  });

  final NewsModel newsModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => NavigateTo(
        context,
        WebViewScreen(url: newsModel.url!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              child: newsModel.image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        '${newsModel.image}',
                        fit: BoxFit.cover,
                      ),
                    )
                  : const Icon(Icons.error_outline),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              newsModel.title!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              newsModel.desc ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
