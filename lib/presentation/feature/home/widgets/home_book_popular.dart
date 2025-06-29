import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/cached_network_image_widget.dart';
import '../../../../utils/formatter.dart';
import '../../../../utils/network_checker.dart';
import '../../../providers/book_infinity_providers.dart';

class HomeBookPopular extends ConsumerStatefulWidget {
  final ScrollController scrollController;

  const HomeBookPopular({super.key, required this.scrollController});

  @override
  ConsumerState<HomeBookPopular> createState() => _HomeBookPopularState();
}

class _HomeBookPopularState extends ConsumerState<HomeBookPopular> {

  double _lastOffset = 0;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() async {
    final position = widget.scrollController.position;

    if (position.pixels <= _lastOffset) {
      _lastOffset = position.pixels;
      return;
    }

    _lastOffset = position.pixels;

    if (position.pixels >= position.maxScrollExtent - 300) {
      final isLoading = ref.read(isLoadingMoreProvider);
      if (isLoading) return;

      if (!NetworkChecker.isConnected) {
        Fluttertoast.showToast(
          msg: "You're offline. No more data loaded",
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
        );
        return;
      }

      ref.read(isLoadingMoreProvider.notifier).state = true;
      await ref.read(bookPaginationProvider('popular').notifier).fetchNextPage();
      ref.read(isLoadingMoreProvider.notifier).state = false;
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookState = ref.watch(bookPaginationProvider('popular'));
    final isLoadingMore = ref.watch(isLoadingMoreProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            'Popular Books',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              fontFamily: 'AvenirNext',
            ),
          ),
        ),
        bookState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error:
              (err, st) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text('Error: $err'),
              ),
          data: (books) {
            return Column(
              children: [
                ListView.separated(
                  itemCount: books.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  padding: const EdgeInsets.only(bottom: 16),
                  itemBuilder: (context, index) {
                    final book = books[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: InkWell(
                        onTap: () {
                          context.push('/detail/${book.id}', extra: book);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImageWidget(
                                  imageUrl: book.imageUrl,
                                  width: 60,
                                  height: 90,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      book.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        fontFamily: 'AvenirNext',
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      book.author,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                        fontFamily: 'AvenirNext',
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.menu_book_outlined,
                                          color: Colors.redAccent,
                                          size: 14,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${formatNumber(book.downloadCount)} Downloads',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                if (isLoadingMore)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: CircularProgressIndicator()),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
