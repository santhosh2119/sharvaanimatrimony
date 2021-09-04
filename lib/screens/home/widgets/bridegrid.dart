import 'package:flutter/material.dart';
import 'package:sharvaanimatrimony/conts/colors.dart';
import 'package:sharvaanimatrimony/conts/dimensions.dart';
import 'package:sharvaanimatrimony/conts/styles.dart';
import 'package:sharvaanimatrimony/screens/home/checkScreen.dart';

class BrideGrid extends StatelessWidget {
  final data;
  final String direction;

  BrideGrid({
    @required this.data,
    @required this.direction,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: data.isEmpty
          ? Center(child: Text("No Data "))
          : GridView.builder(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              itemCount: data.length,
              scrollDirection:
                  direction == 'horizontal' ? Axis.horizontal : Axis.vertical,
              itemBuilder: (context, index) {
                print('data length in grid');
                print(data.length);
                return GridTile(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CheckScreen(data: data[index]),
                          ));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      color: offwhite,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(
                                Dimensions.PADDING_SIZE_DEFAULT),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(data[index]
                                          .profileImage ==
                                      'no Image'
                                  ? "https://sharvaanimatrimony.com/uploads/profile_image/default.jpg"
                                  : "https://sharvaanimatrimony.com/uploads/profile_image/" +
                                      data[index].profileImage),
                            ),
                          ),
                          SizedBox(
                            height: direction == 'horizontal' ? 5 : 10,
                          ),
                          Text(
                            data[index].firstName,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: poppinsMedium.copyWith(
                              fontSize: Dimensions.FONT_SIZE_DEFAULT,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: direction == 'horizontal' ? 5 / 3 : 2 / 2.5,
                crossAxisCount: direction == 'horizontal' ? 1 : 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
            ),
    );
  }
}
