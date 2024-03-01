import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:oktoast/oktoast.dart';

import 'src/config/router/app_router.dart';
import 'src/config/themes/app_themes.dart';
import 'src/domain/repositories/api_repository.dart';
import 'src/domain/repositories/database_repository.dart';
import 'src/locator.dart';
import 'src/presentation/cubits/local_articles/local_articles_cubit.dart';
import 'src/presentation/cubits/remote_articles/remote_articles_cubit.dart';
import 'src/utils/constants/strings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();
  await dotenv.load();

  runApp(const BulletinBoard());
}

class BulletinBoard extends StatelessWidget {
  const BulletinBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LocalArticlesCubit(
            locator<DatabaseRepository>(),
          )..getAllSavedArticles(),
        ),
        BlocProvider(
          create: (context) => RemoteArticlesCubit(
            locator<ApiRepository>(),
          )..getBreakingNewsArticles(),
        )
      ],
      child: OKToast(
        child: MaterialApp.router(
          title: appTitle,
          theme: AppTheme.light,
          debugShowCheckedModeBanner: false,
          routerDelegate: appRouter.delegate(),
          routeInformationParser: appRouter.defaultRouteParser(),
        ),
      ),
    );
  }
}
