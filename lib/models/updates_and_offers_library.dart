class UpdateAndOfferslibrary {
  String title, body, imgUrl;
  int index;

  UpdateAndOfferslibrary({this.title, this.body, this.imgUrl, this.index});
}

List<UpdateAndOfferslibrary> updates_and_offers = [
  UpdateAndOfferslibrary(
      title: 'UPDATE AND OFFER 1', body: 'This is the body 1', imgUrl: 'assets/test1.jpg', index: 1),
  UpdateAndOfferslibrary(
      title: 'UPDATE AND OFFER 2', body: 'This is the body 2', imgUrl: 'assets/test2.jpg', index: 2),
];
