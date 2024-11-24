abstract class NewsEvent {}

class FetchNews extends NewsEvent {
  final String country;

  FetchNews(this.country);
}
