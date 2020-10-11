import 'package:flutter/material.dart';
import 'package:viral/models/cart.dart';
import 'package:viral/widget/cart_item.dart';
import 'package:viral/widget/title.dart';
import 'package:provider/provider.dart';

class LocationCart extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: 'Location Cart'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (ctx, i) => CartDetail(
                  cart.items.values.toList()[i].id,
                  cart.items.keys.toList()[i],
                  cart.items.values.toList()[i].price,
                  cart.items.values.toList()[i].views,
                  cart.items.values.toList()[i].name,
                ),
              ),
            ),
            FlatButton(
              onPressed: () {},
              child: CustomText(text: 'ASSIGN'),
            ),
          ],
        ),
      ),
    );
  }
}
