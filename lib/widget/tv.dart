import 'package:flutter/material.dart';

class TvWidget extends StatelessWidget {
  final String name, address;

  const TvWidget({
    Key key,
    @required this.name,
    @required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.check_box_outline_blank),
        trailing: Icon(Icons.arrow_drop_down),
        title: Text('$name | ' + ' $address'),
      ),
    );
  }
}
