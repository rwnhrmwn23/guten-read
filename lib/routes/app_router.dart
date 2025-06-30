import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../presentation/feature/detail/page/detail_page.dart';
import '../presentation/feature/favorite/page/favorite_page.dart';
import '../presentation/feature/home/page/home_page.dart';
import '../presentation/feature/search/page/search_page.dart';
import '../shared/constants/text_constant.dart';
import '../shared/widgets/bottom_nav.dart';

final routeProvider =Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: routingIndex,
    routes: [
      ShellRoute(
        builder: (context, state, child) => BottomNav(child: child),
        routes: [
          GoRoute(
            path: routingIndex,
            builder: (context, state) => HomePage()
          ),
          GoRoute(
              path: routingSearch,
              builder: (context, state) => SearchPage()
          ),
          GoRoute(
              path: routingFavorite,
              builder: (context, state) => FavoritePage()
          ),
        ],
      ),
      GoRoute(
        path: routingDetail,
        builder: (context, state) {
          final bookId = state.extra as int;
          return DetailPage(bookId: bookId);
        },
      ),
    ],
  );
});
