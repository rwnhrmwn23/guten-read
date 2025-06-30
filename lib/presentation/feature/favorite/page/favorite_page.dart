import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gutenread/shared/widgets/home_app_bar.dart';

import '../../../../shared/widgets/cached_network_image_widget.dart';
import '../../../providers/book_providers.dart';

class FavoritePage extends ConsumerStatefulWidget {
  const FavoritePage({super.key});

  @override
  ConsumerState<FavoritePage> createState() => _FavoritePage();
}

class _FavoritePage extends ConsumerState<FavoritePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(favoriteBooksProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bookState = ref.watch(favoriteBooksProvider);

    return Scaffold(
      appBar: const HomeAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: bookState.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, st) => Center(child: Text('Error: $err')),
                data: (books) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (books.isNotEmpty) ...[
                        Text(
                          'My Favorite',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: 'AvenirNext',
                          ),
                        ),
                        SizedBox(height: 12),
                      ],
                      Expanded(
                        child:
                            books.isEmpty
                                ? Center(
                                  child: Text(
                                    'No favorite books yet',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      fontFamily: 'AvenirNext',
                                    ),
                                  ),
                                )
                                : ListView.separated(
                                  itemCount: books.length,
                                  separatorBuilder:
                                      (_, __) => const SizedBox(height: 16),
                                  padding: const EdgeInsets.only(bottom: 16),
                                  itemBuilder: (context, index) {
                                    final book = books[index];
                                    return InkWell(
                                      onTap: () async {
                                        await context.push(
                                          '/detail/${book.id}',
                                          extra: book.id,
                                        );
                                        ref.invalidate(favoriteBooksProvider);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
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
                                            Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child:
                                                      CachedNetworkImageWidget(
                                                        imageUrl: book.imageUrl,
                                                        width: 60,
                                                        height: 90,
                                                      ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          book.title,
                                                          maxLines: 2,
                                                          overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                          style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'AvenirNext',
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        top: 5,
                                                        left: 5,
                                                        child: Container(
                                                          width: 25,
                                                          height: 25,
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            shape:
                                                                BoxShape.circle,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color:
                                                                    Colors
                                                                        .black12,
                                                                blurRadius: 4,
                                                              ),
                                                            ],
                                                          ),
                                                          child: Center(
                                                            child: IconButton(
                                                              icon: const Icon(
                                                                Icons.favorite,
                                                                size: 15,
                                                              ),
                                                              onPressed: () async {
                                                                await ref.read(
                                                                  toggleFavoriteProvider(
                                                                    book.id,
                                                                  ),
                                                                )();
                                                                ref.invalidate(
                                                                  favoriteBooksProvider,
                                                                );
                                                              },
                                                              color:
                                                                  Colors
                                                                      .redAccent,
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              constraints:
                                                                  const BoxConstraints(),
                                                              splashRadius: 16,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 8),
                                                  Text(
                                                    book.author,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey[600],
                                                      fontFamily: 'AvenirNext',
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    book.summary,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey,
                                                      fontFamily: 'AvenirNext',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
