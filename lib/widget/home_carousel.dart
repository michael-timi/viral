import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class HomeCarousel extends StatelessWidget {
  const HomeCarousel({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      height: 250,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      width: MediaQuery.of(context).size.width,
      child: Carousel(
        images: [
          ExactAssetImage("assets/test2.jpg"),
          NetworkImage(
              'https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),
          ExactAssetImage("assets/test1.jpg")
        ],
        dotSize: 4.0,
        dotSpacing: 15.0,
        dotColor: Theme.of(context).primaryColor,
        indicatorBgPadding: 5.0,
        dotBgColor: Theme.of(context).backgroundColor,
        borderRadius: true,
      ),
    );
  }
}
