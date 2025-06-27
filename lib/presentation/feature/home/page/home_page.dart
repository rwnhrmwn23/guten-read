import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/home_app_bar.dart';
import '../widgets/home_book_popular.dart';
import '../widgets/home_book_recommended_for_your.dart';

class HomePage extends ConsumerWidget {
  final ScrollController _scrollController = ScrollController();

  HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            HomeBookRecommendedForYour(),
            HomeBookPopular(scrollController: _scrollController),
          ],
        ),
      ),
    );
  }
}


