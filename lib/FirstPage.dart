import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:tournafestassignment/constants.dart';
class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
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
      )
    );
  }
}
