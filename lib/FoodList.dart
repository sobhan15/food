import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food/FoodData.dart';
import 'package:food/FoodGroups.dart';
import 'package:food/FoodItem.dart';
import 'FoodData.dart' as FoodData;
import 'package:http/http.dart' as http;
import 'AppData.dart' as AppData;

import 'Basket.dart';
import 'ResturanList.dart';

class FoodList extends StatefulWidget {
  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  double starRating;
  bool activeFood = false;
  bool activeResturan = true;
  bool activeBasket = false;
  String title = "رستوران ها";
  var initFutureGetdataFood;
  var initFutureGetDataResturan;

  List basketFood = [];

  PageController verPageController;
  PageController horPageController;

  @override
  void initState() {
    super.initState();
    verPageController = PageController(initialPage: 0);
    horPageController = PageController(viewportFraction: 0.85);

    initFutureGetdataFood = getDataFood();
    initFutureGetDataResturan = getDataResturan();
  }

  @override
  void dispose() {
    verPageController.dispose();
    horPageController.dispose();
    super.dispose();
  }

  Widget rightTolbarItem(String name, bool isActive, IconData icon) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.height * 0.30,
      child: RotationTransition(
          turns: AlwaysStoppedAnimation(90 / 360),
          child: isActive
              ? Icon(
                  icon,
                  size: 30,
                  color: Theme.of(context).primaryColor,
                )
              : Icon(
                  icon,
                  color: Colors.grey,
                )),
    );
  }

  void toolbarItemOption(
      bool activeFood, bool activeResturan, bool activeBasket) {
    setState(() {
      this.activeFood = activeFood;
      this.activeResturan = activeResturan;
      this.activeBasket = activeBasket;
    });
  }

  Future<List<Food>> getDataFood() async {
    List<Food> list;
    String link = "${AppData.BaseUrl}/getFoodData";
    var response = await http.post(Uri.encodeFull(link));
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      print(data);
      list = data.map((json) => Food.fromJson(json)).toList();
    }

    return list;
  }

  void _refreshResturanState(_) {
          initFutureGetdataFood = getDataFood();

  }

  Widget setDataInFoodItem(List<Food> list) {
    return PageView.builder(
      itemCount: list.length,
      controller: horPageController,
      onPageChanged: (v) {
        print(v);
      },
      itemBuilder: (context, position) {
        return FoodItem(
          foodId:list[position].foodId,
          resturanId:list[position].resturanId,
          imageFood: list[position].foodImage,
          nameFood: list[position].foodName,
          descFood: list[position].foodDesc,
          nameResturan: list[position].resturanName,
          ratingFood: list[position].foodRate.toDouble(),
          pricefood: list[position].foodPrice,
          off: list[position].off,
          mitigation: null,
          person: list[position].person,
          capacityFood: list[position].capacityFood,
          resturanState: list[position].resturanState,
          refreshResturanState:_refreshResturanState
        );
      },
    );
  }

  Future getFoodByGroup(String nameGroup) async {
    List<Food> list;
    String link = "${AppData.BaseUrl}/getFoodByGroup";
    var body = {"groupFood": nameGroup};
    var response = await http.post(Uri.encodeFull(link), body: body);
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      print(data);
      list = data.map((json) => Food.fromJson(json)).toList();
    }

    return list;
  }

  void kababGroup(_) {
    setState(() {
      initFutureGetdataFood = getFoodByGroup("کباب");
    });
    verPageController.animateToPage(1,
        duration: Duration(milliseconds: 1200), curve: Curves.linearToEaseOut);
  }

  void ashGroup(_) {
    setState(() {
      initFutureGetdataFood = getFoodByGroup("آش");
    });
    verPageController.animateToPage(1,
        duration: Duration(milliseconds: 1200), curve: Curves.linearToEaseOut);
  }

  void khoreshGroup(_) {
    setState(() {
      initFutureGetdataFood = getFoodByGroup("خورش");
    });
    verPageController.animateToPage(1,
        duration: Duration(milliseconds: 1200), curve: Curves.linearToEaseOut);
  }

  void fastFoodGroup(_) {
    setState(() {
      initFutureGetdataFood = getFoodByGroup("فست فود");
    });
    verPageController.animateToPage(1,
        duration: Duration(milliseconds: 1200), curve: Curves.linearToEaseOut);
  }

  Future<List<Food>> getFoodById(int resturanId) async {
    List<Food> list;
    String link = "${AppData.BaseUrl}/getFoodByName";
    var body = {"resturan_id": resturanId.toString()};
    var response = await http.post(Uri.encodeFull(link), body: body);
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      list = data.map((json) => Food.fromJson(json)).toList();
    }
    return list;
  }

  Future<List<ResturanData>> getDataResturan() async {
    List<ResturanData> list;
    String link = "${AppData.BaseUrl}/getResturanData";
    var response = await http.post(Uri.encodeFull(link));
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      list = data.map((json) => ResturanData.fromJson(json)).toList();
    }
    return list;
  }

  Widget ResturanItem(List<ResturanData> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, position) {
        return GestureDetector(
          onTap: () {
            print(list[position].resturanId);
            setState(() {
              initFutureGetdataFood = getFoodById(list[position].resturanId);
            });

            verPageController.animateToPage(1,
                duration: Duration(milliseconds: 1200),
                curve: Curves.linearToEaseOut);
          },
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5),
                child: Image.network(
                  list[position].banner,
                  width: MediaQuery.of(context).size.width * 1,
                  fit: BoxFit.fill,
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Colors.black12,
                      Colors.black26,
                      Theme.of(context).primaryColor.withOpacity(0.9)
                    ])),
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  margin: EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: Text(
                    list[position].name,
                    style: TextStyle(fontSize: 19, color: Colors.white),
                  ),
                  height: 30,
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                  width: MediaQuery.of(context).size.width * 0.8,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.home,
            color: Colors.white,
          ),
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            print("Hi There!");
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Container(
          child: Stack(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: MediaQuery.of(context).size.height * 1,
                    child: Column(
                      children: <Widget>[
                        Text(""),
                        GestureDetector(
                            onTap: () {
                              toolbarItemOption(false, true, false);
                              verPageController.animateToPage(0,
                                  duration: Duration(milliseconds: 800),
                                  curve: Curves.linearToEaseOut);
                            },
                            child: rightTolbarItem("رستوران", activeResturan,
                                Icons.restaurant)),
                        Text(""),
                        GestureDetector(
                            onTap: () {
                              toolbarItemOption(true, false, false);
                              verPageController.animateToPage(1,
                                  duration: Duration(milliseconds: 1200),
                                  curve: Curves.linearToEaseOut);
                            },
                            child: rightTolbarItem(
                                "غذا ها", activeFood, Icons.fastfood)),
                        Text(""),
                        GestureDetector(
                            onTap: () {
                              toolbarItemOption(false, false, true);
                              verPageController.animateToPage(2,
                                  duration: Duration(milliseconds: 800),
                                  curve: Curves.linearToEaseOut);
                            },
                            child: rightTolbarItem(
                                "دسته بندی", activeBasket, Icons.border_all)),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.02),
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 10),
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.09,
                          child: Text(
                            title,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            height: MediaQuery.of(context).size.height * 0.75,
                            child: PageView(
                              controller: verPageController,
                              onPageChanged: (v) {
                                if (v == 0) {
                                  toolbarItemOption(false, true, false);
                                  setState(() {
                                    title = "رستوران ها";
                                  });
                                } else if (v == 1) {
                                  toolbarItemOption(true, false, false);

                                  setState(() {
                                    title = "رستوران چاپاتی";
                                  });
                                } else if (v == 2) {
                                  toolbarItemOption(false, false, true);

                                  setState(() {
                                    title = "دسته بندی";
                                  });
                                }
                              },
                              scrollDirection: Axis.vertical,
                              children: <Widget>[
                                Center(
                                    child: FutureBuilder(
                                  future: initFutureGetDataResturan,
                                  builder: (context, snapShot) {
                                    if (snapShot.hasData) {
                                      return ResturanItem(snapShot.data);
                                    } else if (snapShot.hasError) {
                                      return Center(
                                        child: Text(
                                            "برنامه با مشکل مواجه شده است لطفا بعدا امتحان کنید"),
                                      );
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          backgroundColor:
                                              Theme.of(context).primaryColor,
                                          valueColor: AlwaysStoppedAnimation(
                                              Theme.of(context).accentColor),
                                        ),
                                      );
                                    }
                                  },
                                )),
                                FutureBuilder(
                                  future: initFutureGetdataFood,
                                  builder: (context, snapShot) {
                                    if (snapShot.hasData) {
                                      return setDataInFoodItem(snapShot.data);
                                    } else if (snapShot.hasError) {
                                      return Center(
                                          child: Text(
                                              "در دریافت اطلاعات مشکلی بوجود آمده است،لطفا بعدا امتحان کنید"));
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          backgroundColor:
                                              Theme.of(context).primaryColor,
                                          valueColor: AlwaysStoppedAnimation(
                                              Theme.of(context).accentColor),
                                        ),
                                      );
                                    }
                                  },
                                ),
                                FoodGroups(
                                  kababGroup: kababGroup,
                                  ashGroup: ashGroup,
                                  fastFoodGroup: fastFoodGroup,
                                  khoreshGroup: khoreshGroup,
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Basket(
                                        basketdata: FoodData.basketFood,
                                      )));
                        },
                        child: Text(
                          "سبد خرید",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      Text(
                        "نقشه",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text("           "),
                      Text(
                        "سفارشات",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        "خروج",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                  color: Theme.of(context).primaryColor,
                ),
              )
            ],
          ),
        ));
  }
}

class Food {
  int resturanId;
  int foodId;
  int resturanState;
  String foodName;
  String foodDesc;
  int foodPrice;
  int capacityFood;
  String foodGroup;
  int off;
  String person;
  int foodRate;
  String foodImage;
  String resturanName;

  Food({
    this.resturanId,
    this.foodId,
    this.resturanState,
    this.foodName,
    this.foodDesc,
    this.foodPrice,
    this.capacityFood,
    this.foodGroup,
    this.off,
    this.person,
    this.foodRate,
    this.foodImage,
    this.resturanName,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
        resturanId: json["resturan_id"],
        foodId: json["id"],
        resturanState: json["resturanState"],
        foodName: json["name"],
        foodDesc: json["description"],
        foodRate: json["rate"],
        foodGroup: json["groupFood"],
        foodPrice: json["priceFood"],
        capacityFood: json["capacityFood"],
        off: json["off"],
        person: json["person"],
        resturanName: json["resturanName"],
        foodImage: json["image"]);
  }
}
