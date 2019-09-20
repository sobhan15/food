import 'package:flutter/material.dart';
import "FoodData.dart" as FoodData;

class Basket extends StatefulWidget {
  final List basketdata;

  const Basket({Key key, this.basketdata}) : super(key: key);

  @override
  _BasketState createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  String nameFood;
  String imageFood;
  int priceFood;
  String person;
  int totalPrice = 0;
  int mitigation = 0;
  List basketData;
  @override
  void initState() {
    super.initState();

    basketData = widget.basketdata;
    getTotalPrice();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getTotalPrice() {
    for (int i = 0; i < basketData.length; i++) {
      totalPrice += basketData[i]["totalPrice"];
      mitigation += basketData[i]["mitigation"];
      print(totalPrice);
      print("$mitigation : is mitigation");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FoodData.basketFood.length == 0
          ? Center(
              child: Text("سبد خرید شما خالی است"),
            )
          : Container(
              child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.2,
                  ),
                  child: ListView.builder(
                    itemCount: FoodData.basketFood.length,
                    itemBuilder: (context, position) {
                      var data = basketData[position];

                      return Dismissible(
                        key: Key(data["nameFood"]),
                        
                        onDismissed: (v) {
                            totalPrice -= basketData[position]["totalPrice"];
                            mitigation -= basketData[position]["mitigation"];

                          setState(() {
                            basketData.removeAt(position);
                            print(totalPrice);
                          });
                        },
                        background: Container(
                          color: Colors.red,
                        ),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.all(2.5),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.centerRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                    Colors.white10,
                                    Colors.white30,
                                    Theme.of(context).primaryColor,
                                  ])),
                              width: MediaQuery.of(context).size.width * 1,
                              height: MediaQuery.of(context).size.height * 0.15,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 1,
                              height: MediaQuery.of(context).size.height * 0.15,
                              margin: EdgeInsets.all(2.5),
                              child: Row(
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    child: Image.asset(
                                      "images/${data["imageFood"]}.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Text(
                                          data["nameFood"],
                                          style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            "به تعداد : ${data["orderCount"]}"),
                                        Text("قیمت : ${data["priceFood"]} "),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: basketData == null
                      ? Container()
                      : Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("قیمت کل : ",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 22)),
                                  Text("قبل از تخفیف : $totalPrice تومان ",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 15)),
                                  Text("بعد از تخفیف : $mitigation تومان",
                                      style: TextStyle(
                                          color: Colors.green, fontSize: 17)),
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      var data = FoodData.basketFood;

                                      print(data[0]["nameFood"]);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Text(
                                        "پرداخت آنلاین",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                      width: 100,
                                      height: 40,
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Text(
                                        "پرداخت حضوری",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                      width: 100,
                                      height: 40,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height * 0.2,
                          color: Theme.of(context).primaryColor,
                        ),
                )
              ],
            )),
    );
  }
}
