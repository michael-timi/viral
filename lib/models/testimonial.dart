import 'package:flutter/material.dart';

class Testimonial {
  String name, company, testimony, imgUrl;
  int index;

  Testimonial(
      {this.name, this.company, this.testimony, this.imgUrl, this.index});
}

List<Testimonial> testimonial = [
  Testimonial(
      name: 'Atilola Gbenga',
      company: 'Fortress Clothings',
      testimony: 'Our WhatsApp account had the most DM engagements over Instagram, Twitter and Facebook. In reaching more audience on WhatsApp, Viral was recommended and the results was satisfactory for a fashion company.',
      imgUrl: 'assets/image1.jpg'),

  Testimonial(
      name: 'Taiwo Adaraniwon Esq',
      company: 'Lawyer (Bells University)',
      testimony: 'WhatsApp was just the first channel to turn to for visibility. I used WhatsApp to reach small and informal businesses for company formation and contract writing and Viral was really helpful in achieving this.',
      imgUrl: 'assets/image3.jpg'),
  Testimonial(
      name: 'Adeife Samiat',
      company: 'Awareness Beauty Hub',
      testimony: 'WhatsApp TV marketing is the digital way of gaining word of mouth. Having many micro influencers promoting a product is very productive.',
      imgUrl: 'assets/image4.jpg'),
  Testimonial(
      name: 'Matthew Igba',
      company: 'Peak Tutors | thepeaktutors.com',
      testimony: 'We used WhatsApp TV influencers to grow Peak Tutors Youtube Channel to the point of monetisation within a week.',
      imgUrl: 'assets/image5.jpg'),
  Testimonial(
      name: 'Superboycheque',
      company: 'Artist',
      testimony: 'Viral has made it easy for WhatsApp to be considered for music promotion, with more advancement in analytics I would definitely recommend Viral.',
      imgUrl: 'assets/image6.jpg'),
  Testimonial(
      name: 'Jodrey (Mr Ideal Nigeria)',
      company: 'Aceride | acerideng.com',
      testimony: 'The world is indeed closer with WhatsApp. I strongly recommend this platform to you because most of our leads at Ace Ride came from WhatsApp marketing.',
      imgUrl: 'assets/image7.jpg')
];
