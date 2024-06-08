import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/catagory_news.dart';
import 'package:flutter_application_1/models/catgory_news_model.dart';
import 'package:flutter_application_1/models/news_channels_headlines_model.dart';
import 'package:flutter_application_1/models/news_detailed_screen.dart';
import 'package:flutter_application_1/view_model/news_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _ScreenState();
}

final format = DateFormat("MMMM,dd,yyyy");

enum NewsFilters { aljazeera, cNN, bbc, aBC, nDTV, thetimesofindia }

class _ScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  NewsFilters? selectedMenue;
  final formate = DateFormat("MMMM,dd,yyyy");
  String name = 'abc-news';
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).height * 1;
    final height = MediaQuery.sizeOf(context).height * 1;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CatagoryNews()));
          },
          icon: Image.asset(
            "Images/category_icon.png",
          ),
        ),
        centerTitle: true,
        title: Text(
          "Headlines",
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        actions: [
          PopupMenuButton<NewsFilters>(
            icon: const Icon(
              Icons.more_vert_outlined,
              color: Colors.black,
            ),
            onSelected: (NewsFilters item) {
              if (NewsFilters.aBC.name == item.name) {
                name = 'abc-news';
              }
              if (NewsFilters.aljazeera.name == item.name) {
                name = 'al-jazeera-english';
              }
              if (NewsFilters.bbc.name == item.name) {
                name = 'bbc-news';
              }
              if (NewsFilters.thetimesofindia.name == item.name) {
                name = 'the-times-of-india';
              }
              if (NewsFilters.cNN.name == item.name) {
                name = 'CNN';
              }
              setState(() {
                selectedMenue = item;
              });
            },
            initialValue: selectedMenue,
            itemBuilder: (BuildContext content) =>
                <PopupMenuEntry<NewsFilters>>[
              const PopupMenuItem<NewsFilters>(
                value: NewsFilters.aBC,
                child: Text('ABC'),
              ),
              const PopupMenuItem<NewsFilters>(
                value: NewsFilters.aljazeera,
                child: Text('Aljazeera'),
              ),
              const PopupMenuItem<NewsFilters>(
                value: NewsFilters.bbc,
                child: Text("bbc-news"),
              ),
              const PopupMenuItem<NewsFilters>(
                value: NewsFilters.cNN,
                child: Text("CNN"),
              ),
              const PopupMenuItem<NewsFilters>(
                value: NewsFilters.thetimesofindia,
                child: Text("the-times-of-india"),
              ),
            ],
          )
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * .55,
            width: width,
            child: FutureBuilder<NewsChannelsHeadLinesModel>(
              // errors
              future: newsViewModel.newsChannelHeadlinesAPI(name),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitCircle(
                      size: 50,
                      color: Colors.blue,
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.articles!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      DateTime dateTime = DateTime.parse(snapshot
                          .data!.articles![index].publishedAt
                          .toString());
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewsDetailedScreen(
                                  auhter: snapshot.data!.articles![index].author
                                      .toString(),
                                  content: snapshot.data!.articles![index].content
                                      .toString(),
                                  description: snapshot
                                      .data!.articles![index].description
                                      .toString(),
                                  newsImage: snapshot
                                      .data!.articles![index].urlToImage
                                      .toString(),
                                  newsDate: snapshot
                                      .data!.articles![index].publishedAt
                                      .toString(),
                                  newstitle: snapshot.data!.articles![index].title
                                      .toString(),
                                  source: snapshot
                                      .data!.articles![index].source!.name
                                      .toString()),
                            ),
                          );
                        },
                        child: SizedBox(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: height * 0.6,
                                width: width * 0.5,
                                padding: EdgeInsets.symmetric(
                                    horizontal: height * 0.03),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot
                                        .data!.articles![index].urlToImage
                                        .toString(),
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      child: spintkit2,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                      Icons.error_outline_outlined,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                child: Card(
                                  elevation: 5,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    padding: const EdgeInsets.all(10),
                                    height: height * .22,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: width * .2,
                                          child: Text(
                                            snapshot
                                                .data!.articles![index].title!
                                                .toString(),
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        Container(
                                          width: width * .4,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot.data!.articles![index]
                                                    .source!.name
                                                    .toString(),
                                                maxLines: 4,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                formate.format(dateTime),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: FutureBuilder<CatgoryNewsModel>(
              future: newsViewModel.fetchCatgoryNewsAPI("generals"),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitCircle(
                      size: 50,
                      color: Colors.blue,
                    ),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.articles!.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      DateTime dateTime = DateTime.parse(snapshot
                          .data!.articles![index].publishedAt
                          .toString());
                      return Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: snapshot
                                    .data!.articles![index].urlToImage
                                    .toString(),
                                fit: BoxFit.cover,
                                height: height * .13,
                                width: width * .2,
                                placeholder: (context, url) => Container(
                                  child: spintkit2,
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                  Icons.error_outline_outlined,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              child: Container(
                            height: height * .10,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    snapshot.data!.articles![index].title
                                        .toString(),
                                    maxLines: 2,
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                const Spacer(),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 0),
                                        child: Text(
                                          snapshot.data!.articles![index]
                                              .source!.name
                                              .toString(),
                                          maxLines: 1,
                                          style: GoogleFonts.poppins(
                                              fontSize: 10,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 0),
                                        child: Text(
                                          format.format(dateTime),
                                          style: GoogleFonts.poppins(
                                              fontSize: 10,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ))
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

const spintkit2 = SpinKitFadingCircle(color: Colors.blue, size: 50);
