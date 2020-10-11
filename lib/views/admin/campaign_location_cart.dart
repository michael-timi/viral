import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:viral/models/campaign.dart';
import 'package:viral/widget/colors.dart';
import 'package:viral/widget/title.dart';

class SelectCampaignCart extends StatefulWidget {
  final Campaigns campaigns;
  final GlobalKey<ScaffoldState> globalKey;

  SelectCampaignCart({Key key, this.campaigns, this.globalKey})
      : super(key: key);
  @override
  _SelectCampaignCartState createState() => _SelectCampaignCartState();
}

class _SelectCampaignCartState extends State<SelectCampaignCart> {
  @override
  Widget build(BuildContext context) {
    Widget buildSelectedDetails(BuildContext context, Campaigns campaigns) {
      return Hero(
          tag: 'SelectedLocation-${campaigns.tv}',
          transitionOnUserGestures: true,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: SingleChildScrollView(
                child: Container(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(
                            left: 12.0, bottom: 12.0, top: 12.0),
                        child: Column(
                          children: [
                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: AutoSizeText(widget.campaigns.url,
                                      maxLines: 3,
                                      style: TextStyle(fontSize: 18.0)),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: <Widget>[
                                Icon(Icons.monetization_on,
                                    size: 15,
                                    color: Theme.of(context).primaryColor),
                                SizedBox(width: 5),
                                Text('\N${widget.campaigns.price.toString()}'),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Icon(Icons.remove_red_eye,
                                    size: 15,
                                    color: Theme.of(context).primaryColor),
                                SizedBox(width: 5),
                                Text(widget.campaigns.views),
                              ],
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
              ),
            ),
          ));
    }

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), color: white),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [CustomText(text: widget.campaigns.hashtag)],
                  ),
                ),
              ),
              buildSelectedDetails(context, widget.campaigns)
            ],
          ),
        ),
      )),
    );
  }
}
