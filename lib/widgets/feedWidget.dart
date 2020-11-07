import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class FeedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (ctx, i) => FeedItemsBuilder(),
    );
  }
}

class FeedItemsBuilder extends StatelessWidget {
  const FeedItemsBuilder({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.amberAccent,
                ),
                SizedBox(width: 6),
                Text(
                  'Name',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          AspectRatio(
            aspectRatio: 5 / 4,
            child: Container(
              color: Colors.amberAccent,
            ),
          ),
          SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: DefaultTextStyle.merge(
                    style: TextStyle(color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('title',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        ReadMoreText(
                          'description ubackiutfuaesva fsdfucwaebekjv afcsd vcesuf smrlf beufsn fdvdv butvej g drsfvbiesjtb reuk erg yiuerkg eriguhoes9r8e gke ygbs8eruh',
                          trimLines: 2,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: ' read_more',
                          trimExpandedText: ' read_less',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: null,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
