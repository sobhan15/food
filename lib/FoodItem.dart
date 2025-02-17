import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'FoodData.dart' as FoodData;

class FoodItem extends StatefulWidget {
  final int foodId;
  final int resturanId;
  final String imageFood;
  final String nameFood;
  final String descFood;
  final String nameResturan;
  final int ratingFood;
  final int pricefood;
  final int off;
  final int mitigation;
  final String person;
  final int capacityFood;
  final int resturanState;

  const FoodItem({
    Key key,
    this.foodId,
    this.resturanId,
    this.imageFood,
    this.nameFood,
    this.descFood,
    this.nameResturan,
    this.ratingFood,
    this.pricefood,
    this.off,
    this.mitigation,
    this.person,
    this.capacityFood,
    this.resturanState,
  }) : super(key: key);

  @override
  _FoodItemState createState() => _FoodItemState();
}

class _FoodItemState extends State<FoodItem> {
  String imageFood;
  String nameFood;
  String descFood;
  String nameResturan;
  int ratingFood;
  int pricefood;
  int off;
  int mitigation;
  String person;
  int capacityFood;
  int resturanState;
  int orderCount = 0;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
   // widget.refreshResturanState(null);
    setState(() {
      imageFood = widget.imageFood;
      nameFood = widget.nameFood;
      descFood = widget.descFood;
      nameResturan = widget.nameResturan;
      ratingFood = widget.ratingFood;
      pricefood = widget.pricefood;
      off = widget.off;
      mitigation = pricefood - (pricefood * (off / 100)).toInt();
      person = widget.person;
      capacityFood = widget.capacityFood;
      resturanState = widget.resturanState;
      person = widget.person;
    });

    print("resturan State iS $resturanState");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 1,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      child: Image.network(
                        imageFood,
                        width: MediaQuery.of(context).size.width * 1,
                        height: MediaQuery.of(context).size.height * 0.3,
                        fit: BoxFit.cover,
                      )),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black54,
                            Colors.black12,
                            Theme.of(context).accentColor,
                          ])),
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        child: Image.network(
                          imageFood,
                          fit: BoxFit.cover,
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.amber, shape: BoxShape.circle),
                      width: 100,
                      height: 100,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 1,
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text(
                        nameFood,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      width: MediaQuery.of(context).size.width * 1,
                      child: Text(
                        descFood,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 1,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RatingBar(
                        ignoreGestures: true,
                        onRatingUpdate: null,
                        itemCount: 5,
                        itemSize: 30,
                        glowColor: Theme.of(context).primaryColor,
                        initialRating: ratingFood/10,
                        allowHalfRating: true,
                        itemBuilder: (context, _) {
                          return Icon(
                            Icons.star,
                            color: Theme.of(context).primaryColor,
                          );
                        },
                      ),
                      Text("${ratingFood/10}",style: TextStyle(fontSize: 30,color: Colors.black),)
                        ],
                      )
                    ),
                    Container(
                        margin: EdgeInsets.only(right: 5),
                        width: MediaQuery.of(context).size.width * 1,
                        alignment: Alignment.centerRight,
                        child: Stack(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(Icons.attach_money, color: Colors.black54),
                                Text(
                                  "$pricefood تومان",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black54),
                                ),
                              ],
                            ),
                            Positioned(
                              top: 10,
                              child: Container(
                                height: 2,
                                width:
                                    MediaQuery.of(context).size.width * 0.425,
                                color: Colors.red,
                              ),
                            )
                          ],
                        )),
                    Container(
                        margin: EdgeInsets.only(right: 5),
                        width: MediaQuery.of(context).size.width * 1,
                        alignment: Alignment.centerRight,
                        child: Stack(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(Icons.attach_money),
                                Text(
                                  "$mitigation تومان",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ],
                        )),
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      width: MediaQuery.of(context).size.width * 1,
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.person),
                          Text(" "),
                          Text("$person نفره"),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      width: MediaQuery.of(context).size.width * 1,
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.restaurant_menu),
                          Text(" "),
                          Text(" پرس باقی مانده : ${widget.capacityFood}"),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      width: MediaQuery.of(context).size.width * 1,
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.restaurant,
                            size: 25,
                          ),
                          Text(" "),
                          Text("$nameResturan"),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      width: MediaQuery.of(context).size.width * 1,
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(child: Text("تعداد : ")),
                          GestureDetector(
                            onTap: () {
                              if (orderCount > 0) {
                                setState(() {
                                  orderCount--;
                                });
                              }
                            },
                            child: Container(
                              width: 20,
                              alignment: Alignment.center,
                              height: 20,
                              child: Icon(
                                Icons.remove,
                                size: 20,
                              ),
                            ),
                          ),
                          Text(" "),
                          Container(
                            child: Text(orderCount.toString()),
                          ),
                          Text(" "),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                orderCount++;
                              });
                            },
                            child: Container(
                              width: 20,
                              alignment: Alignment.center,
                              height: 20,
                              child: Icon(
                                Icons.add,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (orderCount == 0) {
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            duration: Duration(seconds: 1),
                            backgroundColor: Theme.of(context).primaryColor,
                            content: Text(
                              "لطفا تعداد غدا هارا مشخص کنید",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ));
                        } else if (orderCount > capacityFood) {
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            duration: Duration(milliseconds: 1500),
                            backgroundColor: Colors.orange,
                            content: Text(
                              "به تعداد $capacityFood پرس غذا میتوانید سفارش دهید",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ));
                        } else {
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            duration: Duration(seconds: 1),
                            backgroundColor: Colors.green,
                            content: Text(
                              "به تعداد $orderCount عدد $nameFood به سبد خرید شما اضافه شد",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ));
                          var prefs = await SharedPreferences.getInstance();
                          var userId = prefs.getString("user_id");
                          var pickFood = {
                            "food_id": widget.foodId.toString(),
                            "user_id": userId,
                            "resturan_id": widget.resturanId.toString(),
                            "nameFood": nameFood,
                            "imageFood": imageFood,
                            "descFood": descFood,
                            "priceFood": pricefood,
                            "orderCount": orderCount,
                            "mitigation": mitigation * orderCount,
                            "totalPrice": pricefood * orderCount
                          };

                          FoodData.basketFood.add(pickFood);

                          print(FoodData.basketFood);
                        }
                      },
                      child: Container(
                        width: 80,
                        height: 30,
                        alignment: Alignment.center,
                        child: Text(
                          "ثبت",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  ],
                ),
                Positioned(
                  left: -25,
                  top: 25,
                  child: RotationTransition(
                    turns: AlwaysStoppedAnimation(-45 / 360),
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: 20,
                      child: Text(
                        "$off %",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Center(
                  child: resturanState == 0
                      ? Container(
                          decoration: BoxDecoration(
                              color: Colors.black45,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height * 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset("images/resturanClose.png"),
                              Text(
                                "رستوران بسته است",
                                style: TextStyle(
                                    fontSize: 30, color: Colors.white),
                              )
                            ],
                          ),
                        )
                      : null,
                )
              ],
            )),
      ),
    );
  }
}
