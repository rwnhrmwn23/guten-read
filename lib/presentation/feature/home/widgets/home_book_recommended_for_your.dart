import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/cached_network_image_widget.dart';
import '../../../providers/book_providers.dart';
import 'home_book_error.dart';

class HomeBookRecommendedForYour extends ConsumerWidget {
  const HomeBookRecommendedForYour({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booksPopular = ref.watch(bookListProvider('ascending'));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            'Recommended for you',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              fontFamily: 'AvenirNext',
            ),
          ),
        ),
        SizedBox(
          height: 150,
          child: booksPopular.when(
            data:
                (list) => ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final book = list[index];
                    return InkWell(
                      onTap: () {
                        context.push('/detail/${book.id}', extra: book.id);
                      },
                      child: SizedBox(
                        width: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            AspectRatio(
                              aspectRatio: 3 / 4,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImageWidget(
                                  imageUrl: book.imageUrl,
                                )
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, _) => SizedBox(width: 12),
                ),
            loading: () => Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) {
              if (error is DioException) {
                if (error.response?.statusCode == 404) {
                  return HomeBookError(errorText: 'Book not found (404).');
                } else {
                  return HomeBookError(
                    errorText:
                        'Oops! Something went wrong: No Intenet Connection',
                  );
                }
              }
              return HomeBookError(errorText: 'Unexpected error: $error');
            },
          ),
        ),
      ],
    );
  }
}
