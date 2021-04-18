
import 'package:flutter/material.dart';
import '../data/data.dart';


class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}


class _CalculatorState extends State<Calculator> {

  //--------------------------Variables---------------------------

  //Params
  String selectedCurrency="EUR";
  String selectedPair="EURUSD";
  //Input
  double capital=0.0, percentageRisk=0.0, pipRisk=0.0, exchangeRate=0.0;
  double decimalPlace=0.0001;
  int contractSize=100000;
  //OutPut
  double capitalAtRisk=0.0;
  double riskValuePerPip=0.0;
  double lotSize=0.0;


  //--------------------------Widget Creator----------------------

  Row getPairTradedRow(){


    List<DropdownMenuItem<String>> dropdownItems = [];
    for(String pairs in pairsList){
      var newItem = DropdownMenuItem(
        child: Text(pairs),
        value: pairs,
      );
      dropdownItems.add(newItem);
    }
    
    return Row(
                children: <Widget>[
                    Text("Pair Traded : "),
                    Spacer(),
                    DropdownButton<String>(
                        value: selectedPair,
                        items: dropdownItems,
                        onChanged: (valuePair){
                          setState((){
                            selectedPair = valuePair;
                      
                          });
              
                        },
                      )

                   
                ],
    );
  }

 
  TextField getAccountSizeTextField(){
    return  TextField(
                onChanged: (val) {
                  setState(() {
                    capital = double.parse(val);
                  });
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Capital"
                ),
    );
  }

  TextField getRiskPercentageTextField(){
    return  TextField(
                onChanged: (val) {
                  setState(() {
                    percentageRisk = double.parse(val);
                    percentageRisk = percentageRisk / 100;
                  });
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Percentage Risk"
                ),
    );
  }

  TextField getStopLossPipTextField(){
    return  TextField(
                onChanged: (val) {
                  setState(() {
                    pipRisk = double.parse(val);
                  });
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Stop loss (pips)"
                ),
    );
  }

  Row getAccountCurrencyRow(){

    List<DropdownMenuItem<String>> dropdownItems = [];
    for(String currency in currenciesList){
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }


    return  Row(
                children: <Widget>[
                    Text("Account Currency :"),
                    Spacer(),
                    DropdownButton<String>(
                        value: selectedCurrency,
                        items: dropdownItems,
                        onChanged: (value){
                          setState((){
                            selectedCurrency = value;
                          
                          });
              
                        },
                      )
                ],
    );
  }

  Row getContractSizeRow(){
    return  Row(
                children: <Widget>[
                  Text("Contract Size"),
                  Spacer(),
                  GestureDetector(
                    onTap:(){
                      setState((){
                        double contractSizeDouble = contractSize.toDouble() / 10;
                        contractSize = contractSizeDouble.toInt();
                      });
                    },
                    child: Icon(Icons.remove_circle)
                  ),
                  SizedBox(width:8,),
                  Text("$contractSize"),
                  SizedBox(width:8,),
                  GestureDetector(
                    onTap:(){
                      setState((){
                        double contractSizeDouble = contractSize.toDouble() * 10;
                        contractSize = contractSizeDouble.toInt();
                      });
                    },
                    child: Icon(Icons.add_circle)
                  ), 
                  
                ],
    );
  }


  GestureDetector getCalculateButton(){
    return GestureDetector(
                      onTap:(){
                        getCapitalAtRisk();
                        getLotSize();
                      },
                      child: Container(
                      padding: EdgeInsets.symmetric(vertical:12, horizontal:24),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(24)
                      ),
                      child: Text("Calculate", style: TextStyle(
                        color: Colors.white,
                        fontSize: 17
                      ),)
                    
                    ),
    );
  }


  //--------------------------Call Api--------------------
  
  Future getData() async {
    try {
      double data = await PairData().getPairData(selectedCurrency,selectedPair);
      setState(() {
        exchangeRate = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }



  //-------------------------Calculation Functions--------------
  
  void getCapitalAtRisk() {
    setState(() {
      capitalAtRisk = capital * percentageRisk;
    });
  }


  void getLotSize() async {
    await getData();
    if(selectedPair.substring(3,6) == "JPY"){
      setState((){
         decimalPlace=0.01;
      });
    } else {
       setState((){
         decimalPlace=0.0001;
      });
    }
    setState((){
        riskValuePerPip = (decimalPlace * contractSize)/exchangeRate;
        lotSize = capitalAtRisk / (pipRisk * riskValuePerPip);
    });

  }

  //--------------------------Main Building Area----------------


    @override
    Widget build(BuildContext context) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          body : Container(
            padding: EdgeInsets.symmetric(horizontal:30, vertical:50),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              //Logo
              Image.asset("assets/image-logo.png", height: 100, width: 100),
              SizedBox(height: 25,),
              //Pair Traded
              getPairTradedRow(),
              SizedBox(height: 16,),
              //Account Size
              getAccountSizeTextField(),
              //Risk Percentage
              getRiskPercentageTextField(),
              //Stop loss Pip 
              getStopLossPipTextField(),
              //Spacer
              SizedBox(height:20,),
              //Account Currnecy
              getAccountCurrencyRow(),
              //Spacer
              SizedBox(height:20,),
              //Contract size 
              getContractSizeRow(),
              SizedBox(height:20,),
              //Calculate 
              getCalculateButton(),
              SizedBox(height: 16,),
              Text("Exchange Rate $selectedPair : $exchangeRate"), 
              SizedBox(height:8,),
              capitalAtRisk != 0 ? Text("Capital At Risk : $capitalAtRisk") : Container(), 
              SizedBox(height:8,),
              lotSize != 0 ? Text("Lot Size : $lotSize") : Container(),
          ], 
          )
        ),
      );
        
    
    }
}