import 'package:flutter/material.dart';

class Testimonial {
  final String name, company, testimony, imgUrl;

  Testimonial(
      {@required this.name,
      @required this.company,
      @required this.testimony,
      @required this.imgUrl});
}

Testimonial one = Testimonial(name: '', company: '', testimony: '', imgUrl: '');
Testimonial two = Testimonial(name: '', company: '', testimony: '', imgUrl: '');
Testimonial three = Testimonial(name: '', company: '', testimony: '', imgUrl: '');
Testimonial four = Testimonial(name: '', company: '', testimony: '', imgUrl: '');
Testimonial five = Testimonial(name: '', company: '', testimony: '', imgUrl: '');

List<Testimonial> testimonials =[one, two, three, four, five];