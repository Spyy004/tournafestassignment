import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

import '../../constants.dart';
class CommonNavBar extends StatelessWidget {
  const CommonNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SnakeNavigationBar.color(
      shape: bottomBarShape,
      snakeShape: SnakeShape.circle,
      selectedItemColor: CupertinoColors.white,
      snakeViewColor: Color(0xffFC7B71),
      unselectedItemColor: Colors.black,
      backgroundColor: CupertinoColors.white,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home)),
        BottomNavigationBarItem(icon: Icon(Icons.bookmark_border)),
        BottomNavigationBarItem(icon: Icon(Icons.person)),
      ],
    );
  }
}
class MovieCard extends StatelessWidget {
  const MovieCard({
    Key? key,
    required this.height,
    required this.data,
    required this.width,
    required this.idx,
  }) : super(key: key);

  final double height;
  final double width;
  final dynamic data;
  final int idx;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      elevation: 20,
      child: Padding(
        padding: EdgeInsets.only(top: 0.03*height,bottom:0.05*height,left: 0.3*width),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data[idx]["Title"],style: bodyText.copyWith(fontSize: 18,color: Colors.black),),
            Row(
              children: [
                Text(data[idx]["Year"],style: bodyText,),
                SizedBox(width: 0.02*width,),
                Text(data[idx]["Type"],style: bodyText,),
              ],
            ),
            Row(
              children: [
                Icon(Icons.star,color: Colors.red,),
                SizedBox(width: 0.02*width,),
                Text("7.5",style: bodyText.copyWith(fontSize: 14),),
              ],
            )
          ],
        ),
      ),
      color: Colors.white,);
  }
}
class GenreCard extends StatelessWidget {
  String cardname;
  int active;
  GenreCard({
    required this.cardname,
    required this.active,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 10),
        child: Text(cardname,style: bodyText.copyWith(color: active==1?Colors.white:Colors.black54),),
      ),
      elevation: 20,
      color: active==1?Color(0xffFD7468):Colors.white,
    );
  }
}
class MoviePoster extends StatelessWidget {
  const MoviePoster({
    Key? key,
    required this.width,
    required this.data,
    required this.idx,
    required this.height,
  }) : super(key: key);

  final double width;
  final dynamic data;
  final double height;
  final int idx;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width*0.25,
      height: height*0.2,
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
              fit: BoxFit.fill,
              scale: 1,
              image: NetworkImage(
                data[idx]["Poster"],
              )
          )
      ),
    );
  }
}