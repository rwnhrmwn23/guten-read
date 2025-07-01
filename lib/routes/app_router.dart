import 'package:go_router/go_router.dart';

import '../presentation/feature/detail/page/detail_page.dart';
import '../presentation/feature/favorite/page/favorite_page.dart';
import '../presentation/feature/home/page/home_page.dart';
import '../presentation/feature/onboarding/page/onboarding_page.dart';
import '../presentation/feature/search/page/search_page.dart';
import '../shared/constants/text_constant.dart';
import '../shared/widgets/bottom_nav.dart';

GoRouter createRouter({required bool hasFinishedOnboarding}) {
  final initialPath = hasFinishedOnboarding ? routingIndex : routingOnboard;

  return GoRouter(
    initialLocation: initialPath,
    routes: [
      ShellRoute(
        builder: (context, state, child) => BottomNav(child: child),
        routes: [
          GoRoute(
            path: routingIndex,
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: routingSearch,
            builder: (context, state) => const SearchPage(),
          ),
          GoRoute(
            path: routingFavorite,
            builder: (context, state) => const FavoritePage(),
          ),
        ],
      ),
      GoRoute(
        path: routingOnboard,
        builder: (context, state) => const OnboardingPage(),
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
}
