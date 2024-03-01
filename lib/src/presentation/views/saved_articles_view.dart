import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

import '../../config/router/app_router.dart';
import '../../domain/models/article.dart';
import '../cubits/local_articles/local_articles_cubit.dart';
import '../widgets/article_widget.dart';

class SavedArticlesView extends HookWidget {
  const SavedArticlesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => appRouter.pop(),
          child: const Icon(
            Ionicons.chevron_back,
            color: Color(0xFFf25042),
          ),
        ),
        title: Text(
          'Saved Articles',
          style: GoogleFonts.libreBodoni(
            textStyle: const TextStyle(
              color: Color(0xFF020826),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: BlocBuilder<LocalArticlesCubit, LocalArticlesState>(
        builder: (_, state) {
          switch (state.runtimeType) {
            case LocalArticlesLoading:
              return const Center(child: CupertinoActivityIndicator());
            case LocalArticlesSuccess:
              return _buildArticlesList(state.articles);
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildArticlesList(List<Article> articles) {
    if (articles.isEmpty) {
      return Center(
          child: Text(
        'NO SAVED ARTICLES',
        style: GoogleFonts.ibmPlexSans(
          textStyle: const TextStyle(
            color: Color(0xFF020826),
          ),
        ),
      ));
    }

    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return ArticleWidget(
          article: articles[index],
          isRemovable: true,
          onRemove: (article) => BlocProvider.of<LocalArticlesCubit>(context)
              .removeArticle(article: article),
          onArticlePressed: (article) => appRouter.push(
            ArticleDetailsViewRoute(article: article),
          ),
        );
      },
    );
  }
}
