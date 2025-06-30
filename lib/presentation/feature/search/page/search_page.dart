import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gutenread/shared/widgets/home_app_bar.dart';
import '../../../../shared/widgets/cached_network_image_widget.dart';
import '../../../providers/search_repository_providers.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  final FocusNode _focusNode = FocusNode();
  bool _showHistory = false;
  bool _submitted = false;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _showHistory = true;
        });
      }
    });

    _searchController.addListener(() {
      if (_debounce?.isActive ?? false) _debounce?.cancel();

      _debounce = Timer(const Duration(milliseconds: 800), () {
        final query = _searchController.text.trim();

        if (query.length >= 3) {
          setState(() {
            _submitted = true;
          });
        } else {
          setState(() {
            _submitted = false;
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submitSearch() {
    setState(() {
      _submitted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final recentSearches = ref.watch(recentSearchesProvider);

    return Scaffold(
      appBar: HomeAppBar(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input Search
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF8F8F8),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      focusNode: _focusNode,
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search...',
                        border: InputBorder.none,
                      ),
                      onSubmitted: (_) => _submitSearch(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search, color: Colors.deepOrange),
                    onPressed: _submitSearch,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Recent Search List
            if (_showHistory)
              recentSearches.when(
                loading: () => const CircularProgressIndicator(),
                error: (e, _) => Text('Error: $e'),
                data: (searches) {
                  if (searches.isEmpty) {
                    return const Text(
                      'No recent searches',
                      style: TextStyle(color: Colors.grey),
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: searches.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 20),
                    itemBuilder: (context, index) {
                      final item = searches[index];
                      return Row(
                        children: [
                          const Icon(Icons.access_time, color: Colors.grey),
                          const SizedBox(width: 12),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                _searchController.text = item.query;
                                _submitSearch();
                              },
                              child: Text(
                                item.query,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff1c1c1e),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              ref.read(deleteSearchQueryProvider(item.id))();
                              ref.invalidate(recentSearchesProvider);
                            },
                            child: const Icon(
                              Icons.close,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            SizedBox(height: 16),
            if (_submitted && _searchController.text.isNotEmpty)
              Expanded(
                child: ref
                    .watch(bookSearchProvider(_searchController.text))
                    .when(
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (e, _) => Center(child: Text('Error: $e')),
                      data: (books) {
                        if (books.isEmpty) {
                          return const Center(child: Text('No results found'));
                        }

                        return ListView.separated(
                          itemCount: books.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final book = books[index];
                            return InkWell(
                              onTap: () {
                                context.push('/detail/${book.id}', extra: book.id);
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
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
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
