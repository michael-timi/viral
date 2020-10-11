import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:viral/models/contact.dart';

class ContactWidget extends StatelessWidget {
  final String contactName;

  const ContactWidget({
    Key key,
    this.contactName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: <Widget>[
            AutoSizeText('PEOPLE IN YOUR NETWORK USING US',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
            Container(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: contactList.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2.0, vertical: 8.0),
                        child: InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.account_circle,
                                  ),
                                  Text(
                                    contactList[index].name,
                                    style: TextStyle(fontSize: 10),
                                  )
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            var uuid = Uuid();
                            print(uuid.v1());
                          },
                        ),
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
