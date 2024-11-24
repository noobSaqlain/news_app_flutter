import 'package:flutter_bloc/flutter_bloc.dart';
import '../repo/news_repo.dart';
import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;

  NewsBloc(this.newsRepository) : super(NewsInitial()) {
    on<FetchNews>((event, emit) async {
      emit(NewsLoading());
      try {
        final articles = await newsRepository.fetchNews(event.country);
        emit(NewsLoaded(articles));
      } catch (e) {
        emit(NewsError("Failed to fetch news: ${e.toString()}"));
      }
    });
  }
}
