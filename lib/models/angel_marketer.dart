class AngelMarketer {
  String id, name, phone, mail, bank, accountNo, status;
  DateTime createdAt, createdBy;

  AngelMarketer(
    this.id,
    this.name,
    this.phone,
    this.mail,
    this.bank,
    this.accountNo,
    this.status,
    this.createdAt,
    this.createdBy,
  );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'mail': mail,
        'bank': bank,
        'accountNo': accountNo,
        'status': status,
        'createdAt': createdAt,
        'updatedAt': createdBy,
      };
}
