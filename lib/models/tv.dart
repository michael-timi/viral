import 'package:cloud_firestore/cloud_firestore.dart';

class Tv {
  String name,
      alias,
      interest,
      location,
      audience,
      phone,
      mail,
      imageUrl,
      country,
      createdBy,
      id,
      views,
      limit,
      remittance,
      angelMarketer,
      company,
      price;
  DateTime createdAt;

  Tv(
    this.name,
    this.alias,
    this.interest,
    this.location,
    this.audience,
    this.phone,
    this.mail,
    this.imageUrl,
    this.country,
    this.createdBy,
    this.id,
    this.views,
    this.limit,
    this.remittance,
    this.angelMarketer,
    this.company,
    this.price,
    this.createdAt,
  );

  Map<String, dynamic> toJson() => {
        'name': name,
        'alias': alias,
        'interest': interest,
        'location': location,
        'price': price,
        'pricePercentage': remittance,
        'angelMarketer': angelMarketer,
        'company': company,
        'audience': audience,
        'views': views,
        'phone': phone,
        'mail': mail,
        'image': imageUrl,
        'limit': limit,
        'country': country,
        'createdBy': createdBy,
        'createdAt': createdAt,
      };

  Tv.fromSnapshot(DocumentSnapshot snapshot)
      : name = snapshot.data()['name'],
        alias = snapshot.data()['alias'],
        interest = snapshot.data()['interest'],
        location = snapshot.data()['location'],
        remittance = snapshot.data()['remittance'],
        phone = snapshot.data()['phone'],
        mail = snapshot.data()['mail'],
        company = snapshot.data()['company'],
        views = snapshot.data()['views'],
        country = snapshot.data()['country'],
        price = snapshot.data()['price'],
        createdAt = snapshot.data()['createdAt'].toDate(),
        id = snapshot.id;
}
