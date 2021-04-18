import "package:flutter/material.dart";


class SliderTile extends StatelessWidget {


  String imageAssetPath, title, desc;
  SliderTile({this.imageAssetPath, this.title, this.desc});

  @override
  Widget build(BuildContext context) {
   return Container(
     padding: EdgeInsets.symmetric(horizontal: 20),
     child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: <Widget>[
         
         Image.asset(imageAssetPath),
         SizedBox(height: 20,),
         Text(title, 
         style: TextStyle(
           fontWeight: FontWeight.bold,
           fontFamily: 'Trajan Pro'
         )),
         SizedBox(height: 12,),
         Text(desc),
         SizedBox(height: 40,),
       ],
       )
   );
  }

}