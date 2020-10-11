import 'package:flutter/material.dart';
import 'package:viral/widget/title.dart';

class CartDetail extends StatelessWidget {
  final String id, locationId, name;
  final int quantity;
  final double price;

  CartDetail(
    this.id,
    this.locationId,
    this.price,
    this.quantity,
    this.name,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: CircleAvatar(
          child: FittedBox(
            child: CustomText(text: '\N$price'),
          ),
        ),
        title: CustomText(text: name),
        subtitle: CustomText(text: 'Total: \N${(price * quantity)}'),
        trailing: CustomText(
          text: '$quantity x',
        ),
      ),
    );
  }
}
