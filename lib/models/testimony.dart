import 'package:viral/models/reviews.dart';

class Testimony {
  final String name;
  final String urlImage;
  final String city;
  final String state;
  final String testimony;
  final String company;
  final int starRating;
  final List<Review> reviews;

  Testimony({
    this.reviews,
    this.name,
    this.urlImage,
    this.city,
    this.state,
    this.testimony,
    this.company,
    this.starRating,
  });
}
List<Testimony> testimonies = [
  Testimony(
    name: 'Atilola Gbenga',
    urlImage: 'assets/image1.jpg',
    testimony: 'Our WhatsApp account had the most DM engagements over Instagram, Twitter and Facebook. In reaching more audience on WhatsApp, Viral was recommended and the results was satisfactory for a fashion company',
    company: 'Fortress Clothings',
    starRating: 4,
    city: 'BODIJA',
    state: 'OYO',
    reviews: Reviews.allReviews,
  ),
  Testimony(
    name: 'JOEY',
    urlImage: 'assets/image2.jpg',
    testimony: 'I use Viral for WhatsApp and Facebook Ads, to promote all my music. Reports on my google analytics dashboard points loads of clicks from WhatsApp. I want to see more of Viral in advanced targeting.',
    company: 'Artist',
    starRating: 4,
    city: 'SOUTH LAT 14',
    state: 'EAST LNG 27',
    reviews: Reviews.allReviews,
  ),
  Testimony(
    name: 'Taiwo Adaraniwon Esq',
    urlImage: 'assets/image3.jpg',
    testimony: 'WhatsApp was just the first channel to turn to for visibility. I used WhatsApp to reach small and informal businesses for company formation and contract writing and Viral was really helpful in achieving this.',
    company: 'Lawyer (Bells University)',
    starRating: 4,
    city: 'SANGO OTA',
    state: 'OGUN',
    reviews: Reviews.allReviews,
  ),
  Testimony(
    name: 'Adeife Samiat',
    urlImage: 'assets/image4.jpg',
    testimony: 'WhatsApp TV marketing is the digital way of gaining word of mouth. Having many micro influencers promoting a product is very productive. Viral was very useful in growing our WhatsApp status views.',
    company: 'Awareness Beauty Hub',
    starRating: 4,
    city: 'ILE-IFE',
    state: 'OSUN',
    reviews: Reviews.allReviews,
  ),
  Testimony(
    name: 'Matthew Igba',
    urlImage: 'assets/image5.jpg',
    testimony: 'We used WhatsApp TV influencers to grow Peak Tutors Youtube Channel to the point of monetisation within a week. We also worked with Viral to attract much students to our WhatsApp learning groups',
    company: 'Peak Tutors',
    starRating: 4,
    city: 'ILE-IFE',
    state: 'OSUN',
    reviews: Reviews.allReviews,
  ),
  Testimony(
    name: 'Superboycheque',
    urlImage: 'assets/image6.jpg',
    testimony: 'Viral has made it easy for WhatsApp to be considered for music promotion, with more advancement in analytics I would definitely recommend Viral. Viral informed us that businesses uses our song in their video ads.',
    company: 'Artist',
    starRating: 4,
    city: 'LEKKI',
    state: 'LAGOS',
    reviews: Reviews.allReviews,
  ),
  Testimony(
    name: 'Jodrey',
    urlImage: 'assets/image7.jpg',
    testimony: 'The world is indeed closer with WhatsApp. I strongly recommend this platform to you because most of our leads at Ace Ride came from WhatsApp marketing.',
    company: 'AceRide, MrIdealNigeria',
    starRating: 4,
    city: 'MAGODO',
    state: 'LAGOS',
    reviews: Reviews.allReviews,
  ),
];
