import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_book_popular.dart';
import '../widgets/home_book_recommended_for_your.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: HomeAppBar(),
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



