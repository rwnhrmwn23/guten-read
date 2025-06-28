import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gutenread/domain/entities/book.dart';
import '../widgets/detail_app_bar.dart';
import '../widgets/detail_full_overview.dart';

class DetailPage extends StatefulWidget {
  final Book book;

  const DetailPage({super.key, required this.book});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isLoved = false;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        appBar: const DetailAppBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Book cover
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    widget.book.imageUrl,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.book.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'AvenirNext',
                ),
              ),
              Text(
                '${widget.book.author} (${widget.book.birthYear} - ${widget.book.deathYear})',
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  fontFamily: 'AvenirNext',
                ),
              ),
              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 12),
              const Text(
                'Overview',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'AvenirNext',
                ),
              ),
              const SizedBox(height: 8),
              DetailFullOverview(text: widget.book.summary),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.all(8),
          child: FloatingActionButton(
            onPressed: () {
              setState(() => isLoved = !isLoved);
              // TODO: Save to local database
            },
            backgroundColor: Colors.white,
            child: Icon(
              Icons.favorite,
              color: isLoved ? Colors.redAccent : Colors.grey[400],
            ),
          ),
        ),
      ),
    );
  }
}
