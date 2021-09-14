import 'package:flutter/material.dart';

class CastCard extends StatelessWidget {
  const CastCard({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor:Colors.grey,
            ),
            SizedBox(
              width: 0.07*width,
            ),
            Text("Actor 1"),
          ],
        ),
      ),
    );
  }
}