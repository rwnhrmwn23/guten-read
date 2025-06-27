import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/collection/presentation/page/collection_page.dart';
import '../features/detail/presentation/page/detail_page.dart';
import '../features/home/presentation/page/home_page.dart';
import '../features/search/presentation/page/search_page.dart';
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
              path: '/collection',
              builder: (context, state) => CollectionPage()
          ),
        ],
      ),
      GoRoute(
          path: '/detail/:id',
          builder: (context, state) {
            final id = state.pathParameters['id'];
            return DetailPage(id: id);
          }
      ),
    ],
  );
});
