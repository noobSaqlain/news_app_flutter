import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

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
            Expanded(
              child: ListView(
                children: [
                  Text(
                    article.title ?? 'No Title',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
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
                      ? Image.network(
                          article.urlToImage!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.image_not_supported,
                                size: 200);
                          },
                        )
                      : const Icon(Icons.image_not_supported, size: 200),
                  const SizedBox(height: 16),
                  Text(article.content ?? 'No Content Available'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    if (article.url != null && article.url!.isNotEmpty) {
                      final Uri url = Uri.parse(article.url!);
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Could not open the article URL')),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('No URL available for this article')),
                      );
                    }
                  },
                  icon: const Icon(Icons.open_in_browser),
                  label: const Text('View Article'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
