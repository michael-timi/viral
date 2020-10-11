import 'package:cloud_firestore/cloud_firestore.dart';

class ACampaign {
  String documentId,
      caption,
      hashtag,
      url,
      bc,
      imgUrls,
      videoUrl,
      status,
      views,
      click;
  int price;
  DateTime createdAt, startDate, endDate;

  ACampaign(
      this.caption,
      this.hashtag,
      this.url,
      this.bc,
      this.imgUrls,
      this.price,
      this.createdAt,
      this.startDate,
      this.endDate,
      );

  // formatting for upload to Firebase when creating the campaign
  Map<String, dynamic> toJson() => {
    'caption': caption,
    'hashtag': hashtag,
    'url': url,
    'bc': bc,
    'imgUrl1': imgUrls,
    'createdAt': createdAt,
    'startDate': startDate,
    'endDate': endDate,
  };

  // creating a Trip object from a firebase snapshot
  ACampaign.fromSnapshot(DocumentSnapshot snapshot)
      : caption = snapshot.data()['caption'],
        hashtag = snapshot.data()['hashtag'],
        url = snapshot.data()['url'],
        bc = snapshot.data()['bc'],
        imgUrls = snapshot.data()['imgUrls'],
        createdAt = snapshot.data()['createdAt'].toDate(),
        startDate = snapshot.data()['startDate'].toDate(),
        endDate = snapshot.data()['endDate'].toDate(),
        documentId = snapshot.id;
}
