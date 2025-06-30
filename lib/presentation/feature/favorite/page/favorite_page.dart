import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gutenread/shared/widgets/home_app_bar.dart';

import '../../../../shared/constants/style_constant.dart';
import '../../../../shared/constants/text_constant.dart';
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: bookState.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, st) => Center(child: Text('$error $err')),
                data: (books) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (books.isNotEmpty) ...[
                        Text(myFavorite, style: subTitleStyle),
                        SizedBox(height: 12),
                      ],
                      Expanded(
                        child:
                            books.isEmpty
                                ? Center(
                                  child: Text(
                                    noFavoriteBooks,
                                    style: descriptionStyle,
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
                                        await context.push(routingDetail, extra: book.id,);
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
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
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
                                                          style:
                                                              descriptionBoldStyle,
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
                                                    style: smallTextStyle,
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    book.summary,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: smallTextStyle,
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
