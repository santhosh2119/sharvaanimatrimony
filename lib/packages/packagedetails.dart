import 'package:flutter/material.dart';
import 'package:sharvaanimatrimony/conts/dimensions.dart';
import 'package:sharvaanimatrimony/conts/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class PackageDetails extends StatelessWidget {
  final String packageName;
  final String cost;
  final String id;
  PackageDetails(
      {@required this.packageName, @required this.cost, @required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(packageName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  packageName,
                  style: poppinsMedium.copyWith(
                    fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  cost,
                  style: poppinsMedium.copyWith(
                    fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Dimensions.PADDING_SIZE_DEFAULT,
            ),
            Text(
              'Pay Via Website',
              style: poppinsMedium.copyWith(
                fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(
              height: Dimensions.PADDING_SIZE_DEFAULT,
            ),
            Text(
              'Sorry Package upgrade is available only in website ',
              textAlign: TextAlign.center,
              style: poppinsMedium.copyWith(
                fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
              ),
            ),
            SizedBox(
              height: Dimensions.PADDING_SIZE_DEFAULT,
            ),
            Text(
              'Click On Upgrade Package',
              style: poppinsMedium.copyWith(
                fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
              ),
            ),
            Text(
              'Thank You',
              style: poppinsMedium.copyWith(
                fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
              ),
            ),
            SizedBox(
              height: Dimensions.PADDING_SIZE_DEFAULT,
            ),
            ElevatedButton(
                onPressed: () {
                  launch('https://www.sharvaanimatrimony.com/');
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Upgrade Package",
                    style: poppinsMedium.copyWith(
                      fontSize: 24,
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
