import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../blocs/news_bloc.dart';
import '../blocs/news_event.dart';
import '../blocs/news_state.dart';
import 'news_detail_screen.dart';
import '../shimmer.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  _NewsListScreenState createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NewsBloc>().add(FetchNews('us'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 120, 187, 250),
        toolbarHeight: 80,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Headline News",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Read Top News Today",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                ),
              ],
            ),
            const Icon(
              Icons.newspaper,
              size: 30,
              color: Colors.white,
            ),
          ],
        ),
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsLoading) {
            return ShimmerPlaceholder();
          } else if (state is NewsLoaded) {
            return ListView.builder(
              itemCount: state.articles.length,
              itemBuilder: (context, index) {
                final article = state.articles[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: GestureDetector(
                    onTap: () => _showDetails(context, article),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8.0,
                            offset: Offset(4, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Leading Image that spans the full height
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12.0),
                              bottomLeft: Radius.circular(12.0),
                            ),
                            child: article.urlToImage != null &&
                                    article.urlToImage!.isNotEmpty
                                ? Image.network(
                                    article.urlToImage!,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      // Fallback to icon if image fails to load
                                      return const Icon(
                                        Icons.image_not_supported,
                                        size: 100,
                                      );
                                    },
                                  )
                                : const SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: Icon(
                                      Icons.image_not_supported,
                                      size: 100,
                                    ),
                                  ),
                          ),

                          // Article Text Information
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    article.title ?? 'No Title',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                    maxLines: 2, // Limit title to 2 lines
                                    overflow:
                                        TextOverflow.ellipsis, // Add ellipses
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    article.author ?? 'Unknown Author',
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    article.publishedAt != null
                                        ? 'Published: ${DateFormat('MMM d, y').format(DateTime.parse(article.publishedAt!))}'
                                        : 'Published: date',
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is NewsError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('No news available.'));
        },
      ),
    );
  }

  void _showDetails(BuildContext context, dynamic article) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return NewsDetailScreen(article: article);
      },
    );
  }
}
