import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/models/catgory_news_model.dart';
import 'package:flutter_application_1/models/news_channels_headlines_model.dart';
import 'package:http/http.dart' as http;

class NewsRepository {
  Future<NewsChannelsHeadLinesModel> newChannelHeadlinesAPI(
      String channelName) async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=9486fcfb4a354e52b594339ea7f4254f';
    print(url);

    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelsHeadLinesModel.fromJson(body);
    } else {
      throw Exception("error");
    }
  }

  Future<CatgoryNewsModel> fetchCatgoryNewsAPI(String catagory) async {
    String url =
        'https://newsapi.org/v2/everything?q=${catagory}&from=2024-0426&sortBy=publishedAt&apiKey=9486fcfb4a354e52b594339ea7f4254f';
    print(url);

    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CatgoryNewsModel.fromJson(body);
    } else {
      throw Exception("error");
    }
  }
}
