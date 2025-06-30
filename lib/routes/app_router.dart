import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../presentation/feature/detail/page/detail_page.dart';
import '../presentation/feature/favorite/page/favorite_page.dart';
import '../presentation/feature/home/page/home_page.dart';
import '../presentation/feature/search/page/search_page.dart';
import '../shared/widgets/bottom_nav.dart';

final routeProvider =Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) => BottomNav(child: child),
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => HomePage()
          ),
          GoRoute(
              path: '/search',
              builder: (context, state) => SearchPage()
          ),
          GoRoute(
              path: '/favorite',
              builder: (context, state) => FavoritePage()
          ),
        ],
      ),
      GoRoute(
        path: '/detail/:id',
        builder: (context, state) {
          final bookId = state.extra as int;
          return DetailPage(bookId: bookId);
        },
      ),
    ],
  );
});
