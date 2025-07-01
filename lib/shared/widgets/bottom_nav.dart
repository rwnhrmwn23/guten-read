import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gutenread/shared/constants/style_constant.dart';
import 'package:gutenread/shared/constants/text_constant.dart';

import '../constants/color_constant.dart';

class BottomNav extends StatelessWidget {
  final Widget child;

  const BottomNav({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedLabelStyle: smallTextStyle,
        unselectedLabelStyle: smallTextStyle,
        selectedItemColor: mainRedColor,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex(location),
        onTap: (index) {
          switch (index) {
            case 0:
              context.go(routingIndex);
              break;
            case 1:
              context.go(routingSearch);
              break;
            case 2:
              context.go(routingFavorite);
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: search,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_rounded),
            label: favorite,
          ),
        ],
      ),
    );
  }

  int _currentIndex(String location) {
    if (location.startsWith('/search')) return 1;
    if (location.startsWith('/favorite')) return 2;
    return 0;
  }
}
