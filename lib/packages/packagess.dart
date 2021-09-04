import 'package:flutter/material.dart';
import 'package:sharvaanimatrimony/conts/dimensions.dart';
import 'package:sharvaanimatrimony/conts/styles.dart';
import 'package:sharvaanimatrimony/models/packagesModel.dart';
import 'package:sharvaanimatrimony/packages/packagedetails.dart';

class Packagess extends StatelessWidget {
  final String id;
  Packagess({@required this.id});
  final List<Package> loadedpackages = [
    Package(
      id: 'p1',
      packageName: 'Gold Club',
      packageCost: '1,999.00',
    ),
    Package(
      id: 'p2',
      packageName: 'Platinum Club',
      packageCost: '4,999.00',
    ),
    Package(
      id: 'p3',
      packageName: 'Diamond club',
      packageCost: '9,999.00',
    ),
    Package(
      id: 'p4',
      packageName: 'Elite Club',
      packageCost: '19,999.00',
    ),
    Package(
      id: 'p5',
      packageName: 'Silver',
      packageCost: '1',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Packages')),
        body: ListView.builder(
            itemCount: loadedpackages.length,
            itemBuilder: (BuildContext context, int index) {
              print('working');
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PackageDetails(
                            packageName: loadedpackages[index].packageName,
                            cost: loadedpackages[index].packageCost,
                            id:id)),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          loadedpackages[index].packageName,
                          style: poppinsMedium.copyWith(
                            fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_forward_ios))
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
