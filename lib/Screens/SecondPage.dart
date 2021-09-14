import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:tournafestassignment/Screens/Components/FirstPageUIComponents.dart';
import 'package:tournafestassignment/Services/API.dart';
import 'package:tournafestassignment/constants.dart';
class SecondPage extends StatefulWidget {
  SecondPage({Key? key,required this.imdbId}) : super(key: key);
  final String imdbId;
  @override
  _SecondPageState createState() => _SecondPageState();
}
class _SecondPageState extends State<SecondPage> {
  dynamic singleMovieData;
  GetServices getServices = GetServices();
  Future<dynamic>getSingleMovieData()async
  {
    singleMovieData = await getServices.getSingleMovieDetails(widget.imdbId);
    return singleMovieData;
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: CommonNavBar(),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(top: 20.0,left: 15),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.keyboard_arrow_left,color: Color(0xffFC7B71),),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(top: 20.0,right: 25),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(Icons.bookmark,color: Color(0xffFC7B71),),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<dynamic>(
        future: getSingleMovieData(),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.done) {
            if (snapshot.hasData) {
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            scale: 0.5,
                            image: NetworkImage(
                              snapshot.data["Poster"],
                            )
                        )
                    ),
                  ),
                  Positioned(
                    top: height * 0.35,
                    child: Container(
                        width: width,
                        height: height,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(45),
                                topRight: Radius.circular(45))
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 8.0,left: 135),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(snapshot.data["Title"],style: bodyText.copyWith(fontWeight:FontWeight.bold,color:Colors.black,fontSize: 18),),
                                  SizedBox(height: 0.02*height,),
                                  Text("Director: ${snapshot.data["Director"]}",style: bodyText.copyWith(fontSize: 12),),
                                  SizedBox(height: 0.01*height,),
                                  Text("Runtime: ${snapshot.data["Runtime"]}",style: bodyText.copyWith(fontSize: 12),),
                                  SizedBox(height: 0.01*height,),
                                  Text(snapshot.data["Genre"],style: bodyText.copyWith(fontSize: 12),),
                                  SizedBox(height: 0.01*height,),
                                  Text(snapshot.data["Ratings"][0]["Value"],style: bodyText.copyWith(fontSize: 12),)
                                ],
                              ),
                            )
                          ],
                        )
                    ),
                  ),
                  Positioned(
                      top: height * 0.29,
                      left: width * 0.07,
                      child: Container(
                        width: width * 0.35,
                        height: height * 0.23,
                        decoration: BoxDecoration(
                        image: DecorationImage(
                        fit: BoxFit.fill,
                        scale: 1,
                        image: NetworkImage(
                        snapshot.data["Poster"],
                              )
          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      )
                  ),
                ],
              );
            }
            return Container(
              child: Text("No Data Found"),
            );
          }
          return CircularProgressIndicator();
        }
      ),
    );
  }
}
