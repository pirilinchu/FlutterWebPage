import 'package:auditore_v4/constants.dart';
import 'package:auditore_v4/models/Post.dart';
import 'package:auditore_v4/utils/storage_service.dart';
import 'package:flutter/material.dart';

class PostContainer extends StatelessWidget {
  final Post post;
  PostContainer({Key? key, required this.post}) : super(key: key);

  String addZeroIfNecessary(int date) {
    if (date < 10) {
      return '0$date';
    }
    return '$date';
  }

  Storage storage = Storage();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: FutureBuilder(
                future: storage.downloadURL(post.image),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    if (snapshot.data != null) {
                      return Image.network(
                        snapshot.data!,
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(Images.PLACE_HOLDER),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(Images.PLACE_HOLDER),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }
                  }
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Images.PLACE_HOLDER),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.all(15.0),
              child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                          flex: 3,
                          child: Container(
                              child: Text(
                            post.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          ))),
                      Expanded(
                          flex: 5,
                          child: Container(
                              child: Text(
                            post.body,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 16.0),
                          ))),
                      Expanded(
                          flex: 1,
                          child: Container(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                '${post.author} - ${addZeroIfNecessary(post.date.day)}/${addZeroIfNecessary(post.date.month)}/${post.date.year}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 14.0),
                              ))),
                    ]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
