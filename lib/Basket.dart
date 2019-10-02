import 'package:flutter/material.dart';
import 'package:food/OrderState.dart';
import "FoodData.dart" as FoodData;
import 'AppData.dart' as AppData;
import 'package:http/http.dart' as http;

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
  bool okOrder = false;
  bool isWaiting = false;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
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
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("سبد خرید"),
        actions: <Widget>[
          Center(
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => OrderState()));
                  },
                  child: Text("وضعیت سفارشات")))
        ],
      ),
      body: FoodData.basketFood.length == 0
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.shopping_cart,
                  size: 70,
                  color: Colors.grey,
                ),
                Text(""),
                Text(
                  "سبد خرید شما خالی است",
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
              ],
            ))
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
                        key: Key(
                            "${data["nameFood"]} - ${DateTime.now().millisecondsSinceEpoch}"),
                        onDismissed: (v) {
                          totalPrice -= basketData[position]["totalPrice"];
                          mitigation -= basketData[position]["mitigation"];

                          setState(() {
                            basketData.removeAt(position);
                            print(totalPrice);
                          });
                        },
                        background: Container(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              Icon(
                                Icons.delete,
                                color: Colors.white,
                              )
                            ],
                          ),
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
                                    child: Image.network(
                                      data["imageFood"],
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
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
                                          color: Colors.white, fontSize: 15)),
                                  Text("بعد از تخفیف : $mitigation تومان",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17)),
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     var data = FoodData.basketFood;

                                  //     print(data[0]["nameFood"]);
                                  //   },
                                  //   child: Container(
                                  //     alignment: Alignment.center,
                                  //     decoration: BoxDecoration(
                                  //         color: Colors.white,
                                  //         borderRadius: BorderRadius.all(
                                  //             Radius.circular(20))),
                                  //     child: Text(
                                  //       "پرداخت آنلاین",
                                  //       style: TextStyle(
                                  //           color:
                                  //               Theme.of(context).primaryColor),
                                  //     ),
                                  //     width: 100,
                                  //     height: 40,
                                  //   ),
                                  // ),
                                  GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        isWaiting = true;
                                      });
                                      var response;
                                      for (int i = 0;
                                          i < widget.basketdata.length;
                                          i++) {
                                        var data = widget.basketdata[i];
                                        var userId = data["user_id"];
                                        var foodId = data["food_id"];
                                        var resturanId = data["resturan_id"];
                                        var orderCount = data["orderCount"];
                                        var link =
                                            "${AppData.BaseUrl}/addOrder";

                                        var body = {
                                          "user_id": userId.toString(),
                                          "food_id": foodId.toString(),
                                          "resturan_id": resturanId.toString(),
                                          "orderCount": orderCount.toString(),
                                        };
                                        var reduceLink =
                                            "${AppData.BaseUrl}/reduceCapacity";
                                        var reduceResponse=await http.post(
                                            Uri.encodeFull(reduceLink),
                                            body: {
                                              "food_id":foodId.toString(),
                                              "orderCount":orderCount.toString()
                                            });
                                        response = await http.post(
                                            Uri.encodeFull(link),
                                            body: body);
                                      }
                                      if (response.statusCode == 200) {
                                        setState(() {
                                          okOrder = true;
                                          isWaiting = false;
                                        });
                                      }
                                    },
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
                ),
                Center(
                    child: isWaiting
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(
                                Theme.of(context).accentColor),
                            backgroundColor: Theme.of(context).primaryColor,
                          )
                        : null),
                Center(
                  child: okOrder
                      ? Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.white,
                                Theme.of(context).accentColor,
                                Theme.of(context).primaryColor,
                              ]
                            ),
                              borderRadius:
                                  BorderRadius.all(Radius.elliptical(150, 30))),
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.55,
                          child: ListView(
                            children: <Widget>[
                              Icon(
                                Icons.check,
                                color: Colors.black,
                                size: 75,
                              ),
                              Text(
                                "سفارشات شما با موفقیت ثبت شد ، به زودی از طرف رستوران با شما تماس گرفته خواهد شد ، ضمن اینکه شما میتوانید از بالای صفحه از وضعیت لحظه ای سفارش خود مطلع شوید",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    height: 1.2),
                              ),
                              Text(""),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        okOrder = false;
                                        widget.basketdata.clear();
                                      });
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 40,
                                      alignment: Alignment.center,
                                      color: Colors.white,
                                      child: Text(
                                        "باشه",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      : null,
                )
              ],
            )),
    );
  }
}
