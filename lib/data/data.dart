import 'dart:convert';
import 'package:http/http.dart' as http;

class SliderModel {
    String imagePath;
    String title;
    String desc;

    SliderModel({this.imagePath,this.title,this.desc});

  String getImagePath (){return this.imagePath;} 
  void setImagePath( String imagePath) => this.imagePath = imagePath;

  String getTitle (){return this.title;} 
  void setTitle(String title) => this.title = title;

  String getDesc (){return this.desc;} 
  void setDesc(String desc) => this.desc = desc;
  


}


List<SliderModel> getSlides(){
  
  List<SliderModel> slides = [];
  SliderModel sliderModel = new SliderModel();

  //1
  sliderModel.setImagePath("assets/image-onboarding-1.png");
  sliderModel.setTitle("Position Sizing");
  sliderModel.setDesc("Knowing how much of your capital is at risk is key in preserving it.");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setImagePath("assets/image-onboarding-2.png");
  sliderModel.setTitle("Risk Management");
  sliderModel.setDesc("Market's volatility can be very stressful, but with the proper position sizing and money management, everything goes much smoother. ");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel.setImagePath("assets/image-onboarding-3.png");
  sliderModel.setTitle("Position Size Calculator");
  sliderModel.setDesc("Using a calculator with real time data will be of tremendous help for fast position taking with the proper position size.");
  slides.add(sliderModel);

  return slides;
  
}

const List<String> currenciesList = [
  'AUD',
  'CAD',
  'EUR',
  'GBP',
  'JPY',
  'NZD',
  'CHF',
  'USD',
];

const List<String> pairsList = [
  'AUDCAD',
  'AUDCHF',
  'AUDJPY',
  'AUDNZD',
  'AUDUSD',
  'EURAUD',
  'GBPAUD',
  'CADCHF',
  'CADJPY',
  'EURCAD',
  'GBPCAD',
  'NZDCAD',
  'USDCAD',
  'CHFJPY',
  'EURCHF',
  'GBPCHF',
  'NZDCHF',
  'USDCHF',
  'EURGBP',
  'EURJPY',
  'EURNZD',
  'EURUSD',
  'GBPJPY',
  'GBPNZD',
  'GBPUSD',
  'NZDJPY',
  'NZDCHF',
  'NZDUSD',
  'USDJPY',
];

const apiUrl = 'http://api.exchangeratesapi.io/v1/latest';
const apiKey = 'b3322df321fb0cc658a71d9cffd795bd';

// http://api.exchangeratesapi.io/v1/latest?access_key=b3322df321fb0cc658a71d9cffd795bd&base=GBP&symbols=USD

class PairData {
  Future getPairData(String basePair, String pair) async {


    String symbol = pair.substring(3,6);

    if(basePair == symbol){
      print("hey ho");
      return 1.0;
    }
   
    String requestURL = '$apiUrl?access_key=$apiKey&base=$basePair&symbols=$symbol';
    print(requestURL);
    http.Response response = await http.get(Uri.parse(requestURL));
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
   
      var lastPrice = decodedData['rates'];
      lastPrice = lastPrice[symbol];
 
      return lastPrice;
    } else {
      print(response.statusCode);
      throw 'Problem with the get request';
    }
  }
}
