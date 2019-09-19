import 'dart:core';

import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'FoodData.dart' as FoodData;

class FoodItem extends StatefulWidget {
  final String imageFood;
  final String nameFood;
  final String descFood;
  final double ratingFood;
  final int pricefood;
  final String person;

  const FoodItem(
      {Key key,
      this.imageFood,
      this.nameFood,
      this.descFood,
      this.ratingFood,
      this.pricefood,
      this.person,})
      : super(key: key);

  @override
  _FoodItemState createState() => _FoodItemState();
}

class _FoodItemState extends State<FoodItem> {
  String imageFood;
  String nameFood;
  String descFood;
  double ratingFood;
  int pricefood;
  String person;
  int orderCount = 0;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    setState(() {
      imageFood = widget.imageFood;
      nameFood = widget.nameFood;
      descFood = widget.descFood;
      ratingFood = widget.ratingFood;
      pricefood = widget.pricefood;
      person = widget.person;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: Container(
            decoration: BoxDecoration(
                color: Colors.deepPurple[50],
                borderRadius: BorderRadius.all(Radius.circular(20))),
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 1,
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      child: Image.asset(
                        "images/$imageFood.jpg",
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
                            Colors.deepPurple[50],
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
                        child: Image.asset("images/$imageFood.jpg"),
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
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 1,
                        alignment: Alignment.center,
                        child: SmoothStarRating(
                          color: Colors.red,
                          allowHalfRating: true,
                          starCount: 5,
                          rating: ratingFood == null ? 0 : ratingFood,
                          borderColor: Colors.amber,
                        )),
                    Container(
                      width: MediaQuery.of(context).size.width * 1,
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.attach_money),
                          Text("$pricefood هزار تومان"),
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
                          Icon(Icons.person),
                          Text("$person نفره"),
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
                      onTap: () {
                        if (orderCount == 0) {
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            backgroundColor: Colors.deepPurple[200],
                            content: Text(
                              "لطفا تعداد غدا هارا مشخص کنید",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ));
                        } else {
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(
                              "به تعداد $orderCount عدد $nameFood به سبد خرید شما اضافه شد",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ));

                          var pickFood = {
                            "nameFood": nameFood,
                            "imageFood": imageFood,
                            "descFood": descFood,
                            "priceFood": pricefood,
                            "person": person,
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
                        color: Colors.deepPurple[200],
                      ),
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
