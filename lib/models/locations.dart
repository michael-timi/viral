import 'package:viral/models/reviews.dart';

class Location {
  final String name;
  final String urlImage;
  final String latitude;
  final String longitude;
  final String addressLine1;
  final String addressLine2;
  final int starRating;
  final List<Review> reviews;

  Location({
    this.reviews,
    this.name,
    this.urlImage,
    this.latitude,
    this.longitude,
    this.addressLine1,
    this.addressLine2,
    this.starRating,
  });
}
List<Location> locations = [
  Location(
    name: 'Atilola Gbenga',
    urlImage: 'assets/image1.jpg',
    addressLine1: 'Our WhatsApp account had the most DM engagements over Instagram, Twitter and Facebook. In reaching more audience on WhatsApp, Viral was recommended and the results was satisfactory for a fashion company',
    addressLine2: 'Fortress Clothings',
    starRating: 4,
    latitude: 'BODIJA',
    longitude: 'OYO',
    reviews: Reviews.allReviews,
  ),
  Location(
    name: 'JOEY',
    urlImage: 'assets/image2.jpg',
    addressLine1: 'I use Viral for WhatsApp and Facebook Ads, to promote all my music. Reports on my google analytics dashboard points loads of clicks from WhatsApp. I want to see more of Viral in advanced targeting.',
    addressLine2: 'Artist',
    starRating: 4,
    latitude: 'SOUTH LAT 14',
    longitude: 'EAST LNG 27',
    reviews: Reviews.allReviews,
  ),
  Location(
    name: 'Taiwo Adaraniwon Esq',
    urlImage: 'assets/image3.jpg',
    addressLine1: 'WhatsApp was just the first channel to turn to for visibility. I used WhatsApp to reach small and informal businesses for company formation and contract writing and Viral was really helpful in achieving this.',
    addressLine2: 'Lawyer (Bells University)',
    starRating: 4,
    latitude: 'SANGO OTA',
    longitude: 'OGUN',
    reviews: Reviews.allReviews,
  ),
  Location(
    name: 'Adeife Samiat',
    urlImage: 'assets/image4.jpg',
    addressLine1: 'WhatsApp TV marketing is the digital way of gaining word of mouth. Having many micro influencers promoting a product is very productive. Viral was very useful in growing our WhatsApp status views.',
    addressLine2: 'Awareness Beauty Hub',
    starRating: 4,
    latitude: 'ILE-IFE',
    longitude: 'OSUN',
    reviews: Reviews.allReviews,
  ),
  Location(
    name: 'Matthew Igba',
    urlImage: 'assets/image5.jpg',
    addressLine1: 'We used WhatsApp TV influencers to grow Peak Tutors Youtube Channel to the point of monetisation within a week. We also worked with Viral to attract much students to our WhatsApp learning groups',
    addressLine2: 'Peak Tutors',
    starRating: 4,
    latitude: 'ILE-IFE',
    longitude: 'OSUN',
    reviews: Reviews.allReviews,
  ),
  Location(
    name: 'Superboycheque',
    urlImage: 'assets/image6.jpg',
    addressLine1: 'Viral has made it easy for WhatsApp to be considered for music promotion, with more advancement in analytics I would definitely recommend Viral. Viral informed us that businesses uses our song in their video ads.',
    addressLine2: 'Artist',
    starRating: 4,
    latitude: 'LEKKI',
    longitude: 'LAGOS',
    reviews: Reviews.allReviews,
  ),
  Location(
    name: 'Jodrey',
    urlImage: 'assets/image7.jpg',
    addressLine1: 'The world is indeed closer with WhatsApp. I strongly recommend this platform to you because most of our leads at Ace Ride came from WhatsApp marketing.',
    addressLine2: 'AceRide, MrIdealNigeria',
    starRating: 4,
    latitude: 'MAGODO',
    longitude: 'LAGOS',
    reviews: Reviews.allReviews,
  ),
];
