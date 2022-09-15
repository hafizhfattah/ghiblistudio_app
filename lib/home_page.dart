import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/link.dart';

import 'utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Post>> futurePost;

  @override
  void initState() {
    super.initState();
    futurePost = fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Post>>(
        future: futurePost,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 4,
                            blurRadius: 5,
                            offset: const Offset(0, 7),
                          ),
                        ],
                        color: CupertinoColors.white,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Swiper(
                          //   layout: SwiperLayout.TINDER,
                          //   customLayoutOption:
                          //       CustomLayoutOption(startIndex: -1, stateCount: 3)
                          //         ..addRotate([-45.0 / 180, 0.0, 45.0 / 180])
                          //         ..addTranslate([
                          //           const Offset(-370.0, -40.0),
                          //           const Offset(0.0, 0.0),
                          //           const Offset(370.0, -40.0)
                          //         ]),
                          //   itemWidth: 300.0,
                          //   itemHeight: 200.0,
                          //   itemBuilder: (context, index) {
                          //     return Image.network(
                          //       snapshot.data![index].image,
                          //       fit: BoxFit.fitHeight,
                          //     );
                          //   },
                          //   itemCount: 21,
                          // ),
                          Image.network(
                            snapshot.data![index].image,
                            filterQuality: FilterQuality.high,
                            height: 200,
                            fit: BoxFit.fitHeight,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  snapshot.data![index].title,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                snapshot.data![index].score,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Link(
                            target: LinkTarget.blank,
                            uri:
                                Uri.parse('${snapshot.data![index].locations}'),
                            builder: (context, followLink) => OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(64.0),
                                ),
                              ),
                              onPressed: followLink,
                              child: const Text("List Of Character"),
                            ),
                          ),

                          const SizedBox(height: 10),
                          Text(
                            snapshot.data![index].description,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );

            //if data has eror return =>
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator.adaptive(),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    '${snapshot.error}',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator.adaptive());
        },
      ),
    );
  }
}
