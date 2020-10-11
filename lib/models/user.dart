class User {
  String firstname,
      lastname,
      brand,
      imgUrl,
      website,
      email,
      address,
      accountmanager,
      whatsapp,
      instagram,
      facebook,
      twitter,
      linkedin,
      pin;
  bool admin;

  User(
    this.firstname,
    this.accountmanager,
    this.address,
    this.imgUrl,
    this.brand,
    this.facebook,
    this.instagram,
    this.email,
    this.lastname,
    this.linkedin,
    this.twitter,
    this.website,
    this.whatsapp,
    this.pin,
  );

  Map<String, dynamic> toJson() => {
        'views.admin': admin,
        'firstname': firstname,
        'lastname': lastname,
        'brand': brand,
        'imgUrl': imgUrl,
        'website': website,
        'email': email,
        'address': address,
        'accountmanager': accountmanager,
        'whatsapp': whatsapp,
        'instagram': instagram,
        'facebook': facebook,
        'twitter': twitter,
        'linkedin': linkedin,
        'pin': pin,
      };
}
