

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:tournafestassignment/Services/API.dart';
import 'package:tournafestassignment/constants.dart';
class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  var movieData;
  Future<dynamic>getMovieData()async
  {
    movieData= await GetServices().getAllMovieData();
    return movieData;
  }
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xffE9EFFB),
      appBar: AppBar(
        titleSpacing: width*0.17,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Icon(Icons.search,color: Color(0xffFC7B71),size: 30,),
          )
        ],
        title: Row(
          children: [
            Icon(Icons.location_on,color: Color(0xffFC7B71),),
            SizedBox(
              width: 0.03*width,
            ),
            Text("TO, CANADA",style: bodyText)
          ],
        ),
        leading: Icon(Icons.drag_handle,color: Colors.black,size: 30,),
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        elevation: 10,
        fixedColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items:[
          BottomNavigationBarItem(icon: Icon(Icons.home),label: " "),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark),label: " "),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: " "),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: height*0.05, left: width*0.04),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Popular",style: bodyText.copyWith(fontSize: 22,color: Colors.black),),
                    SizedBox(
                      width: 0.05*width,
                    ),
                    Text("New",style: bodyText.copyWith(fontSize: 20),),
                    SizedBox(
                      width: 0.05*width,
                    ),
                    Text("Upcoming",style: bodyText.copyWith(fontSize: 20),)
                  ],
                ),
                SizedBox(
                  height: 0.04*height,
                ),
                Container(
                  color: Colors.transparent,
                  width: width,
                  height: height*0.06,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      GenreCard(cardname: "Drama",active: 1,),
                      SizedBox(width: 0.05*width,),
                      GenreCard(cardname: "Horror",active: 0,),
                      SizedBox(width: 0.05*width,),
                      GenreCard(cardname: "Comedy",active: 0,),
                      SizedBox(width: 0.05*width,),
                    //  GenreCard(cardname: "Comedy",active: 0,),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: height*0.22,
            left: 0.08*width,
            child: SizedBox(
              height: height*0.6,
              width: width*0.9,
              child: FutureBuilder<dynamic>(
                future: getMovieData(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: 4,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                      return Stack(
                        children: [
                          Column(
                            children: [
                              MovieCard(height: height, width: width,data:snapshot.data["Search"],idx:index),
                              SizedBox(
                                height: 0.1*height,
                              ),
                            ],
                          ),
                          Positioned(
                            bottom: 0.05*height,
                            left: 0.03*width,
                            child: MoviePoster(height: height,width: width,data:snapshot.data["Search"],idx:index)
                          ),
                        ],
                      );
                    },
                  );
                }
              ),
            ),
          ),
        ],
      ),
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
