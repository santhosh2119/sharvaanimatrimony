import 'package:flutter/material.dart';

import 'package:sharvaanimatrimony/screens/home/widgets/bridegrid.dart';
import 'package:sharvaanimatrimony/screens/search/search.dart';

class AllBrideGrid extends StatelessWidget {
  final data;
  final String direction;
  final String from;

  AllBrideGrid({@required this.data, @required this.direction, this.from});

  @override
  Widget build(BuildContext context) {
    print("allbridegrid");
    print(from);
    return Scaffold(
      appBar: from == 'search'
          ? AppBar(
              title: Text("Search Results"),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchScreen()));
                    },
                    icon: Icon(Icons.search))
              ],
            )
          : from == 'interest'
              ? AppBar(
                  title: Text("Interest"),
                )
              : from == 'igonre'
                  ? AppBar(
                      title: Text("Igonre"),
                    )
                  : from == 'followlist'
                      ? AppBar(
                          title: Text("Follow"),
                        )
                      : from == 'shortlist'
                          ? AppBar(
                              title: Text("Short List"),
                            )
                          : AppBar(
                              title: Text("All Bride & Grooms"),
                            ),
      body: BrideGrid(data: data, direction: direction),
    );
  }
}
