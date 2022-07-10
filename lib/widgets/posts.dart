import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

import 'package:auditore_v4/constants.dart';
import 'package:auditore_v4/models/Post.dart';
import 'package:auditore_v4/utils/storage_service.dart';
import 'package:auditore_v4/widgets/post_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../utils/extensions.dart';

class Posts extends StatefulWidget {
  const Posts({Key? key}) : super(key: key);

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  final CarouselController _controller = CarouselController();

  Stream<List<Post>> readPosts() => FirebaseFirestore.instance
      .collection('posts')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => Post.fromJson(doc.data(), doc.id))
          .toList());

  double spacerSize = 10.0;

  Storage storage = Storage();

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 750;

  @override
  Widget build(BuildContext context) {
    Widget buildPost(Post post) => Container(
          child: GestureDetector(
            child: PostContainer(post: post),
            onTap: () {
              openPDF(post);
              //
              //openAlertBox(context, post);
            },
          ),
        );

    List<Widget> content = [];
    if (!isMobile(context)) {
      content.add(
        IconButton(
          onPressed: (() {
            _controller.previousPage();
          }),
          icon: const Icon(Icons.navigate_before_rounded),
          iconSize: 80.0,
        ),
      );
      content.add(
        SizedBox(
          width: spacerSize,
        ),
      );
    }

    content.add(Center(
      child: FutureBuilder(
          future: readPosts().first,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error');
            } else if (snapshot.hasData) {
              final posts = snapshot.data! as List<Post>;

              return CarouselSlider(
                items: posts.map(buildPost).toList(),
                options: CarouselOptions(
                    height: isMobile(context) ? 350.0 : null,
                    aspectRatio: 1.4,
                    enlargeCenterPage: true,
                    viewportFraction: 0.8),
                carouselController: _controller,
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    ));

    if (!isMobile(context)) {
      content.add(
        SizedBox(
          width: spacerSize,
        ),
      );
      content.add(
        IconButton(
          onPressed: (() {
            _controller.nextPage();
          }),
          icon: const Icon(Icons.navigate_next_rounded),
          iconSize: 80.0,
        ),
      );
    } else {
      Widget buttons = Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: (() {
              _controller.previousPage();
            }),
            icon: const Icon(Icons.navigate_before_rounded),
            iconSize: 80.0,
          ),
          IconButton(
            onPressed: (() {
              _controller.nextPage();
            }),
            icon: const Icon(Icons.navigate_next_rounded),
            iconSize: 80.0,
          ),
        ],
      );
      content.add(buttons);
    }

    return Container(
      height: 800.0,
      color: HexColor.fromHex(PageColors.BACKGROUND_COLOR_ONE).withAlpha(100),
      padding: EdgeInsets.only(bottom: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            child: Center(
              child: Text(
                PostsInfo.TITLE,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.normal,
                  color: HexColor.fromHex(PageColors.CONTACT_US_TITLE_COLOR),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.blueGrey[100],
              padding: EdgeInsets.symmetric(
                  vertical: isMobile(context) ? 0.0 : 80.0,
                  horizontal: isMobile(context) ? 0.0 : 0.0),
              child: isMobile(context)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: content,
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: content,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  openAlertBox(BuildContext context, Post post) {
    //final pdfController = PdfController(document: getPDF(post));
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              color: Colors.yellow,
              width: MediaQuery.of(context).size.width < 660
                  ? MediaQuery.of(context).size.width - 60
                  : 600,
              child: Center(
                child: FutureBuilder(
                    future: getPDF(post),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error');
                      } else if (snapshot.hasData) {
                        final pdf = snapshot.data! as String;
                        //openPDF(pdf);
                        return SfPdfViewer.network(pdf);
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
                // child: PdfView(
                //   controller: pdfController,
              ),
            ),
          );
        });
  }

  Future<String> getPDF(Post post) async {
    final url = await storage.downloadPDF(post.pdf);
    return url;
    //return pdf;
  }

  Future<void> _launchInBrowser(Post post) async {
    final url = Uri.parse(await storage.downloadPDF(post.pdf));
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  void openPDF(Post post) {
    _launchInBrowser(post);
  }
}
