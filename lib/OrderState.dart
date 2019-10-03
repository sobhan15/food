import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AppData.dart' as AppData;
import 'package:http/http.dart' as http;

class OrderState extends StatefulWidget {
  @override
  _OrderStateState createState() => _OrderStateState();
}

class _OrderStateState extends State<OrderState> {
  var initGetDAtaOrderState;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool finishOrder = false;
  List<ModelOrderState> list = [];
  @override
  void initState() {
    super.initState();
    getDataOrderState();
    initGetDAtaOrderState = getDataOrderState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<List<ModelOrderState>> getDataOrderState() async {
    var prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString("user_id");
    var link = "${AppData.BaseUrl}/getOrderState";
    var body = {"user_id": userId};
    var response = await http.post(Uri.encodeFull(link), body: body);
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      list = data.map((json) => ModelOrderState.fromJson(json)).toList();
    }
    return list;
  }

  Widget orderSatateItem(List<ModelOrderState> list) {
    if (list.length == 0) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          
          Icon(Icons.sentiment_dissatisfied,size: 60,color: Colors.grey,),
          Text(""),
          Text("شما تا کنون سفارشی ثبت نکرده اید.",style: TextStyle(color: Colors.grey,fontSize: 20),),
        ],)
      );
    }
    return Stack(
      children: <Widget>[
        GridView.count(
          crossAxisCount: 2,
          children: List.generate(
              list.length,
              (i) => Stack(
                    children: <Widget>[
                      Opacity(
                        opacity: 0.35,
                        child: Container(
                          margin: EdgeInsets.all(5),
                          child: Image.network(
                            list[i].foodImage,
                            width: MediaQuery.of(context).size.width * 1,
                            height: MediaQuery.of(context).size.height * 1,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 1,
                        height: MediaQuery.of(context).size.height * 1,
                        margin: EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              list[i].foodName,
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "${list[i].orderCount.toString()} عدد",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              list[i].dateOrder.split(" ").last,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w800),
                            ),
                            Center(
                                child: list[i].orderState == 0
                                    ? Column(
                                        children: <Widget>[
                                          Text(
                                            "در انتظار تایید رستوران",
                                            style: TextStyle(
                                                color: Colors.orange[900],
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(""),
                                          GestureDetector(
                                            onTap: () async {
                                              var link =
                                                  "${AppData.BaseUrl}/setCancel";
                                              var body = {
                                                "order_id":
                                                    list[i].orderId.toString()
                                              };
                                              var incrementLink =
                                                  "${AppData.BaseUrl}/incrementCapacity";
                                              var reduceResponse = await http
                                                  .post(
                                                      Uri.encodeFull(
                                                          incrementLink),
                                                      body: {
                                                    "food_id": list[i]
                                                        .foodId
                                                        .toString(),
                                                    "orderCount": list[i]
                                                        .orderCount
                                                        .toString()
                                                  });
                                              var response = await http.post(
                                                  Uri.encodeFull(link),
                                                  body: body);
                                              if (response.statusCode == 200) {
                                                setState(() {
                                                  initGetDAtaOrderState =
                                                      getDataOrderState();
                                                });
                                                _scaffoldKey.currentState
                                                    .showSnackBar(SnackBar(
                                                  content:
                                                      Text("با موفقیت حذف شد"),
                                                  backgroundColor: Colors.green,
                                                  duration:
                                                      Duration(seconds: 1),
                                                ));
                                              }
                                            },
                                            child: Container(
                                              width: 80,
                                              height: 30,
                                              color: Colors.red[400],
                                              alignment: Alignment.center,
                                              child: Text(
                                                "لغو سفارش",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    : list[i].orderState == 1
                                        ? Text(
                                            "در حال آماده شدن",
                                            style: TextStyle(
                                                color: Colors.green[900],
                                                fontSize: 17,
                                                fontWeight: FontWeight.w700),
                                          )
                                        : list[i].orderState == 2
                                            ? Column(
                                                children: <Widget>[
                                                  Text(
                                                    "در دست پیک",
                                                    style: TextStyle(
                                                        color:
                                                            Colors.brown[900],
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  Text(""),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      var link =
                                                          "${AppData.BaseUrl}/setOrderState";
                                                      var body = {
                                                        "order_id": list[i]
                                                            .orderId
                                                            .toString()
                                                      };
                                                      var response =
                                                          await http.post(
                                                              Uri.encodeFull(
                                                                  link),
                                                              body: body);
                                                      if (response.statusCode ==
                                                          200) {
                                                        setState(() {
                                                          initGetDAtaOrderState =
                                                              getDataOrderState();
                                                          finishOrder = true;
                                                        });
                                                      }
                                                    },
                                                    child: Container(
                                                      width: 80,
                                                      height: 30,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "به دستم رسید",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 13),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            : null),
                          ],
                        ),
                      ),
                    ],
                  )),
        ),
        Center(
          child: finishOrder
              ? Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(150, 30))),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.47,
                  child: ListView(
                    children: <Widget>[
                      Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 75,
                      ),
                      Text(
                        "با تشکر از همراهی شما ، همچنین شما می توانید در قسمت سفارشات از صفحه ی اصلی به غذای مورد نظر امتیاز داده و مارو در ارایه بهتر خدمات همراهی کنید",
                        style: TextStyle(
                            color: Colors.white, fontSize: 18, height: 1.2),
                      ),
                      Text(""),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                finishOrder = false;
                              });
                            },
                            child: Container(
                              width: 100,
                              height: 40,
                              alignment: Alignment.center,
                              color: Colors.white,
                              child: Text(
                                "باشه",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("وضعیت سفارشات"),
        ),
        body: FutureBuilder(
          future: initGetDAtaOrderState,
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return orderSatateItem(snapShot.data);
            } else if (snapShot.hasError) {
              return Center(
                child: Text(
                    "دسترسی به این قسمت امکان پذیر نیست لطفا بعدا امتحان کنید"),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).accentColor,
                  valueColor:
                      AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                ),
              );
            }
          },
        ));
  }
}

class ModelOrderState {
  int foodId;
  int orderId;
  String foodName;
  String foodImage;
  String dateOrder;
  int orderCount;
  int orderState;

  ModelOrderState({
    this.foodId,
    this.orderId,
    this.foodName,
    this.foodImage,
    this.dateOrder,
    this.orderCount,
    this.orderState,
  });

  factory ModelOrderState.fromJson(Map<String, dynamic> json) {
    return ModelOrderState(
      foodId: json["food_id"],
      orderId: json["order_id"],
      foodName: json["foodName"],
      foodImage: json["foodImage"],
      dateOrder: json["dateOrder"],
      orderCount: json["orderCount"],
      orderState: json["orderState"],
    );
  }
}
