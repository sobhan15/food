import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AppData.dart' as AppData;
import 'package:http/http.dart' as http;

class FinishOrders extends StatefulWidget {
  @override
  _FinishOrdersState createState() => _FinishOrdersState();
}

class _FinishOrdersState extends State<FinishOrders> {
  double rate = 30;
  var initFutureGetDataFinishOrer;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    initFutureGetDataFinishOrer = getDataFinishOrder();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future getDataFinishOrder() async {
    var prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString("user_id");
    List<ModelFinishOrder> list;
    var link = "${AppData.BaseUrl}/getFinishOrder";
    var body = {"user_id": userId};
    var response = await http.post(Uri.encodeFull(link), body: body);
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      list = data.map((json) => ModelFinishOrder.fromJson(json)).toList();
    }
    return list;
  }

  Widget itemFinishOrder(List<ModelFinishOrder> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, position) {
        return Container(
          padding: EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).accentColor,
                Colors.white
              ])),
          margin: EdgeInsets.all(2.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 100,
                height: 100,
                color: Colors.red[200],
                child: Image.network(
                  list[position].foodImage,
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(list[position].foodName),
                  Text(list[position].resturanName),
                ],
              ),
              Text(""),
              Text(""),
              Center(
                  child: list[position].isRating == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                GestureDetector(
                                  onLongPress: () {
                                    if (list[position].rate > 10) {
                                      setState(() {
                                        list[position].rate -= 10;
                                      });
                                    }
                                  },
                                  onTap: () {
                                    if (list[position].rate > 0) {
                                      setState(() {
                                        list[position].rate--;
                                      });
                                    }
                                  },
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.remove,
                                      size: 20,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                  ),
                                ),
                                Text("     "),
                                Text(
                                  "${list[position].rate / 10}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                Text("     "),
                                GestureDetector(
                                  onLongPress: () {
                                    if (list[position].rate < 40) {
                                      setState(() {
                                        list[position].rate += 10;
                                      });
                                    }
                                  },
                                  onTap: () {
                                    if (list[position].rate < 50) {
                                      setState(() {
                                        list[position].rate++;
                                      });
                                    }
                                  },
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.add,
                                      color: Theme.of(context).primaryColor,
                                      size: 20,
                                    ),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () async {
                                var link = "${AppData.BaseUrl}/setScore";
                                var body = {
                                  "order_id": list[position].orderId.toString(),
                                  "orderRate": "${list[position].rate}"
                                };
                                print(list[position].isRating);
                                print(list[position].rate);
                                var response = await http
                                    .post(Uri.encodeFull(link), body: body);
                                if (response.statusCode == 200) {
                                  setState(() {
                                    initFutureGetDataFinishOrer =
                                        getDataFinishOrder();
                                  });
                                  _scaffoldKey.currentState
                                      .showSnackBar(SnackBar(
                                    content: Text("با تشکر"),
                                    backgroundColor: Colors.green,
                                    duration: Duration(seconds: 1),
                                  ));
                                }
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "ثبت امتیاز",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  width: 80,
                                  height: 30,
                                  color: Colors.white),
                            )
                          ],
                        )
                      : Row(
                          children: <Widget>[
                            Text(""),
                            Text(
                              "${list[position].isRating/10}",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            Text("    "),
                          ],
                        ))
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("سفارشات"),
        ),
        body: FutureBuilder(
          future: initFutureGetDataFinishOrer,
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return itemFinishOrder(snapShot.data);
            } else if (snapShot.hasError) {
              print("finish order error :  ${snapShot.error}");
              return Center(
                child: Text(
                    "در ارتباط با سرور مشکلی بوجود آمده لطفا بعدا امتحان کنید"),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                  backgroundColor: Theme.of(context).accentColor,
                ),
              );
            }
          },
        ));
  }
}

class ModelFinishOrder {
  int orderId;
  String foodName;
  String foodImage;
  String resturanName;
  int rate;
  int isRating;

  ModelFinishOrder(
      {this.orderId,
      this.foodName,
      this.foodImage,
      this.resturanName,
      this.rate,
      this.isRating});

  factory ModelFinishOrder.fromJson(Map<String, dynamic> json) {
    return ModelFinishOrder(
        orderId: json["order_id"],
        foodName: json["foodName"],
        foodImage: json["foodImage"],
        resturanName: json["resturanName"],
        rate: 30,
        isRating: json["rate"]);
  }
}
