import "package:flutter/material.dart";
import "../data/data.dart";
import "../components/sliderTile.dart";
import "./calculatorPage.dart";

//---------------------------------------

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  List<SliderModel> slides = [];
  int currentIndex = 0;
  PageController pageController = new PageController(initialPage: 0);


  @override
  void initState() {
    super.initState();
    slides = getSlides();
  }


  Widget pageIndexIndicator(bool isCurrentPage){
    return Container(
      margin: EdgeInsets.symmetric(horizontal:2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.grey : Colors.grey[300],
        borderRadius: BorderRadius.circular(12)
      )

    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
          title: Text('POSITION SIZER',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600
          )),
          backgroundColor: Colors.white,

        ),
      body: PageView.builder(
        controller: pageController,
        itemCount: slides.length,
        onPageChanged: (val){
          setState(() {
             currentIndex = val;
          });
        },
          itemBuilder: (context, index){
            return SliderTile(
              imageAssetPath: slides[index].getImagePath(),
              title: slides[index].getTitle(),
              desc: slides[index].getDesc(),
            );
          }),
      bottomSheet: currentIndex != slides.length - 1 ? Container(
        height: 60,
        padding:EdgeInsets.symmetric(horizontal:20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: (){
                pageController.animateToPage(slides.length - 1, duration: Duration(milliseconds: 200), curve: Curves.linear);
              },
              child: Text("SKIP")  
            ),
            Row(
              children: [
                for(int i = 0; i < slides.length; i++) currentIndex ==  i ? pageIndexIndicator(true) : pageIndexIndicator(false)
              ],
            ),
            GestureDetector(
              onTap: (){
                pageController.animateToPage(currentIndex + 1, duration: Duration(milliseconds: 400), curve: Curves.linear);
              },
              child: Text("NEXT")  
            ),
          ],
        ),
      ) 
      : GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
            builder: (context) => Calculator(),)  
            );
          },
          child: Container(
          color: Colors.green[800],
          width: MediaQuery.of(context).size.width,
          height: 60,
          alignment: Alignment.center,
          child: Text("GET STARTED NOW",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600
            ))
        ),
      ),
    );
  }
}
