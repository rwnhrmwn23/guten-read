import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String? id;
  const DetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book #$id')),
      body: Center(child: Text('Detail for Book ID: $id')),
    );
  }
}
