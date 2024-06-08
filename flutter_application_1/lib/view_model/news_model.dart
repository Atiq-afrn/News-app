import 'package:flutter_application_1/models/catgory_news_model.dart';
import 'package:flutter_application_1/models/news_channels_headlines_model.dart';
import 'package:flutter_application_1/repository/news_repository.dart';

class NewsViewModel {
  final _repo = NewsRepository();

  Future<NewsChannelsHeadLinesModel> newsChannelHeadlinesAPI(
      String channelName) async {
    final response = await _repo.newChannelHeadlinesAPI(channelName);
    return response;
  }

  Future<CatgoryNewsModel> fetchCatgoryNewsAPI(String catagory) async {
    final response = await _repo.fetchCatgoryNewsAPI(catagory);
    return response;
  }
}
