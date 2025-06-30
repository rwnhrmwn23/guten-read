import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/constants/style_constant.dart';
import '../../../../shared/constants/text_constant.dart';
import '../../../../shared/widgets/cached_network_image_widget.dart';
import '../../../../utils/formatter.dart';
import '../../../providers/book_providers.dart';
import '../../../../shared/widgets/back_app_bar.dart';
import '../widgets/detail_full_overview.dart';

class DetailPage extends ConsumerStatefulWidget {
  final int bookId;

  const DetailPage({super.key, required this.bookId});

  @override
  ConsumerState<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends ConsumerState<DetailPage> {
  @override
  Widget build(BuildContext context) {
    final bookAsync = ref.watch(bookDetailProvider(widget.bookId));

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: bookAsync.when(
        data: (book) {
          return Scaffold(
            appBar: const BackAppBar(),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImageWidget(
                        imageUrl: book!.imageUrl,
                        height: 250,
                        width: 165,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(book.title, style: titleStyle),
                  Text(authorAndYearInfo(book), style: descriptionStyle),
                  const SizedBox(height: 8),
                  const Divider(),
                  const SizedBox(height: 12),
                  Text(overview, style: subTitleStyle),
                  const SizedBox(height: 8),
                  DetailFullOverview(text: book.summary),
                ],
              ),
            ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(8),
              child: FloatingActionButton(
                onPressed: () async {
                  await ref.read(toggleFavoriteProvider(book.id))();
                  ref.invalidate(bookDetailProvider(book.id));
                },
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.favorite,
                  color: book.isFavorite ? Colors.redAccent : Colors.grey[400],
                ),
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$error $e')),
      ),
    );
  }
}
