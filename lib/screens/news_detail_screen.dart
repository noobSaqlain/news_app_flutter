import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewsDetailScreen extends StatelessWidget {
  final dynamic article;

  NewsDetailScreen({required this.article});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.8,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.title ?? 'No Title',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('By ${article.author ?? 'Unknown Author'}'),
            Text(
              article.publishedAt != null
                  ? 'Published: ${DateFormat('MMM d, y').format(DateTime.parse(article.publishedAt!))}'
                  : 'Published: date',
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 16),
            article.urlToImage != null
                ? Image.network(article.urlToImage!)
                : const Icon(Icons.image_not_supported, size: 200),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Text(article.content ?? 'No Content Available'),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}
