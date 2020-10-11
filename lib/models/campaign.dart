import 'package:cloud_firestore/cloud_firestore.dart';

class Campaigns {
  String documentId,
      caption,
      hashtag,
      url,
      tv,
      bc,
      location,
      imgUrl,
      videoUrl,
      status,
      views,
      click;
  int price;
  DateTime createdAt, startDate, endDate;

  Campaigns(
    this.caption,
    this.hashtag,
    this.url,
    this.tv,
    this.bc,
    this.location,
    this.imgUrl,
    this.videoUrl,
    this.status,
    this.views,
    this.click,
    this.price,
    this.createdAt,
    this.startDate,
    this.endDate,
  );

  // formatting for upload to Firebase when creating the campaign
  Map<String, dynamic> toJson() => {
        'id': documentId,
        'caption': caption,
        'hashtag': hashtag,
        'url': url,
        'tv': tv,
        'bc': bc,
        'location': location,
        'imgUrl': imgUrl,
        'videoUrl': videoUrl,
        'status': status,
        'views': views,
        'click': click,
        'price': price,
        'createdAt': createdAt,
        'startDate': startDate,
        'endDate': endDate,
      };

  // creating a Trip object from a firebase snapshot
  Campaigns.fromSnapshot(DocumentSnapshot snapshot)
      : caption = snapshot.data()['caption'],
        hashtag = snapshot.data()['hashtag'],
        url = snapshot.data()['url'],
        tv = snapshot.data()['tv'],
        bc = snapshot.data()['bc'],
        location = snapshot.data()['location'],
        imgUrl = snapshot.data()['imgUrl'],
        videoUrl = snapshot.data()['videoUrl'],
        status = snapshot.data()['status'],
        views = snapshot.data()['views'],
        click = snapshot.data()['click'],
        price = snapshot.data()['price'],
        createdAt = snapshot.data()['createdAt'].toDate(),
        startDate = snapshot.data()['startDate'].toDate(),
        endDate = snapshot.data()['endDate'].toDate(),
        documentId = snapshot.id;
}
