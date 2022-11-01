import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:katex_flutter/katex_flutter.dart';
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'SI Calculator',
    home: SIForm(),
    theme: ThemeData(
      colorScheme: ColorScheme.dark(),
      brightness: Brightness.dark
    ),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SIFormState();
    throw UnimplementedError();
  }
}

class SIFormState extends State<SIForm> {
  final _formKey = GlobalKey<FormState>();
  var currencies = ["Rupees", "Dollars", "Pounds"];
  String dropdownvalue = '';

  final TextEditingController _laTeXInputController = TextEditingController(
    text:
    r' $$\boxed{\rm{SI} = (\frac{principal \cdot rate \cdot term}{100})}$$'
    '\n'
  );
  String _laTeX ='';
  void initState(){
    _renderLaTeX();
    dropdownvalue = currencies[0];
  }
  TextEditingController principalcontroller = TextEditingController();
  TextEditingController roicontroller = TextEditingController();
  TextEditingController termcontroller = TextEditingController();
  var resultextdisplay = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SI Calculator"),
      ),
      body: Form(
        key: _formKey,
          // margin: EdgeInsets.all(5.0),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: ListView(
            children: [
              Center(
                  child: Container(
                height: 200,
                width: 400,
                child: Image.asset('images/money.png', fit: BoxFit.cover),
              )),
              Padding(
                  padding: EdgeInsets.only(top: 7, bottom: 7),
                  child: TextFormField(
                    controller: principalcontroller,
                    keyboardType: TextInputType.number,
                    validator: (String? value){
                      if(value!.isEmpty){
                        return 'Null value not accepted';
                      }

                    },
                    decoration: InputDecoration(
                        label: Text("Principal"),
                        hintText: "eg. 1200",
                        errorStyle: TextStyle(
                          color: Colors.amberAccent[200]
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 7, bottom: 7),
                  child: TextFormField(
                    controller: roicontroller,
                    keyboardType: TextInputType.number,
                    validator: (String? value){
                      if(value!.isEmpty){
                        return 'Null value not accepted';
                      }
                    },
                    decoration: InputDecoration(
                        errorStyle: TextStyle(
                            color: Colors.amberAccent[200]
                        ),
                        label: Text("Rate of Interest"),
                        hintText: "In %",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),

                        )),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 7, bottom: 7),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: termcontroller,
                          keyboardType: TextInputType.number,
                          validator: (String? value){
                            if(value!.isEmpty){
                              return 'Null value not accepted';
                            }
                          },
                          decoration: InputDecoration(
                              errorStyle: TextStyle(
                                  color: Colors.amberAccent[200]
                              ),
                              label: Text("Term"),
                              hintText: "In years",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              )),
                        ),
                      ),
                      Container(
                        width: 25,
                      ),
                      Expanded(
                          child: DropdownButton(
                        value: dropdownvalue,
                        items: currencies.map((String currencies) {
                          return DropdownMenuItem(
                            value: currencies,
                            child: Text(currencies),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        },
                      ))
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 7, bottom: 7),
                  child: Row(children: [
                    Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                            ),
                            onPressed: (){
                              setState(() {
                                if(_formKey.currentState!.validate()){
                                  calculatetotalreturn();
                                }
                              });
                            },
                            child: Text(
                              "Calculate",
                              style: TextStyle(fontSize: 20 ,color: Colors.white),
                            ))),
                    Container(
                      width: 20,
                    ),
                    Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                            ),

                            onPressed: (){
                              setState(() {
                                cleartext();
                              });
                            },
                            child: Text(
                              "Reset",
                              style: TextStyle(fontSize: 20, color: Colors.white),
                            ))),
                  ])),
              Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(resultextdisplay, style: TextStyle(fontSize: 20),)),


        Container(
            child: Builder(
              builder: (context) => KaTeX(
                laTeXCode: Text(_laTeX,
                    style: Theme.of(context).textTheme.bodyText2),
              )))




            ],
          )),
    ));

    throw UnimplementedError();
  }
  String ?calculatetotalreturn(){
    double principal = double.parse(principalcontroller.text);
    double roi = double.parse(roicontroller.text);
    double term = double.parse(termcontroller.text);
    double finalamount = principal + (principal * roi * term) / 100;
    var symbol = '';
    switch(dropdownvalue){
      case 'Rupees' : symbol = '₹'; break;
      case 'Dollars' : symbol = '\$'; break;
      case 'Pounds' : symbol = '£'; break;
    }

    String result = 'Investment after $term years will be $symbol$finalamount';
    resultextdisplay = result;
    return result;
  }

  void cleartext(){
    principalcontroller.clear();
    roicontroller.clear();
    termcontroller.clear();
    dropdownvalue = currencies[0];
    resultextdisplay = '';
  }
  void _renderLaTeX() {
    setState(() {
      _laTeX = _laTeXInputController.text;
    });
  }

}
