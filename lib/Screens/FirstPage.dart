import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tournafestassignment/Services/API.dart';
import 'package:tournafestassignment/constants.dart';
import 'Components/FirstPageUIComponents.dart';
import 'SecondPage.dart';
class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  dynamic _movieData; // to store the api response
  GetServices getServices = GetServices();  // created an object of class GetServices
  Future<dynamic>getMovieData()async  // function to access the api call function.
  {
    _movieData= await getServices.getAllMovieData();
    return _movieData;
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
            padding:  EdgeInsets.only(top: 15.0,right: 25),
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
        leading: Padding(
          padding:  EdgeInsets.only(top: 10,left: 25),
          child: Icon(Icons.drag_handle,color: Colors.black,size: 30,),
        ),
      ),
      bottomNavigationBar: CommonNavBar(),
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
          ),   // lowest layer of stack
          Positioned(
            top: height*0.22,
            left: 0.08*width,
            child: SizedBox(
              height: height*0.6,
              width: width*0.9,
              child: FutureBuilder<dynamic>(
                future: getMovieData(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState==ConnectionState.done) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: 4,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Column(
                                children: [
                                  InkWell(
                                    child: MovieCard(height: height,
                                        width: width,
                                        data: snapshot.data["Search"],
                                        idx: index),
                                    onTap: () async {
                                      Navigator.push(context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SecondPage(
                                                    imdbId: snapshot
                                                        .data["Search"][index]["imdbID"],
                                                  )));
                                    },
                                  ),
                                  SizedBox(
                                    height: 0.1 * height,
                                  ),
                                ],
                              ),
                              Positioned(
                                  bottom: 0.05 * height,
                                  left: 0.03 * width,
                                  child: MoviePoster(height: height,
                                      width: width,
                                      data: snapshot.data["Search"],
                                      idx: index)
                              ),
                            ],
                          );
                        },
                      );
                    }
                    return Container(
                      child: Center(
                        child: Text("Sorry No Data Available"),
                      ),
                    );
                  }
                  return CircularProgressIndicator();
                }
              ),
            ),
          ), // top most layer of stack
        ],
      ),
    );
  }
}


