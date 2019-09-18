import 'package:flutter/material.dart';
import 'package:food/FoodItem.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

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

  PageController verPageController;
  PageController horPageController;

  @override
  void initState() {
    super.initState();
    verPageController = PageController(initialPage: 0);
    horPageController = PageController(viewportFraction: 0.85);
  }

  @override
  void dispose() {
    verPageController.dispose();
    horPageController.dispose();
    super.dispose();
  }

  Widget rightTolbarItem(String name, bool isActive) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 1,
      height: 70,
      child: RotationTransition(
          turns: AlwaysStoppedAnimation(90 / 360),
          child: isActive
              ? Text(name,
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                      fontWeight: FontWeight.w700))
              : Text(name,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500))),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.home,
            color: Colors.white,
          ),
          backgroundColor: Colors.deepPurple[200],
          onPressed: () {},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Container(
          child: Stack(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        GestureDetector(
                            onTap: () {
                              toolbarItemOption(false, true, false);
                              verPageController.animateToPage(0,
                                  duration: Duration(milliseconds: 800),
                                  curve: Curves.linearToEaseOut);
                            },
                            child: rightTolbarItem("رستوران", activeResturan)),
                        GestureDetector(
                            onTap: () {
                              toolbarItemOption(true, false, false);
                              verPageController.animateToPage(1,
                                  duration: Duration(milliseconds: 1200),
                                  curve: Curves.linearToEaseOut);
                            },
                            child: rightTolbarItem("غذا ها", activeFood)),
                        GestureDetector(
                            onTap: () {
                              toolbarItemOption(false, false, true);
                              verPageController.animateToPage(2,
                                  duration: Duration(milliseconds: 800),
                                  curve: Curves.linearToEaseOut);
                            },
                            child: rightTolbarItem("سبد خرید", activeBasket)),
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
                            width: MediaQuery.of(context).size.width * 0.8,
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
                                    title = "سبد خرید";
                                  });
                                }
                              },
                              scrollDirection: Axis.vertical,
                              children: <Widget>[
                                Center(
                                  child: Text("رستوران"),
                                ),
                                PageView(
                                  controller:horPageController,
                                  onPageChanged: (v) {
                                    print(v);
                                  },
                                  children: <Widget>[
                                    FoodItem(
                                        imageFood: "ghorme",
                                        nameFood: "قورمه سبزی",
                                        descFood:
                                            "برنج ایرانی + ته چین + سبزی + ترشی + لیمو",
                                        ratingFood: 3.5,
                                        pricefood: 13000,
                                        person: "یک"),
                                    FoodItem(
                                        imageFood: "dizi",
                                        nameFood: "دیزی سنگی",
                                        descFood:
                                            "سبزی + پیاز + ترشی بادمجان + دو تکه سنگک",
                                        ratingFood: 5,
                                        pricefood: 10000,
                                        person: "یک"),
                                    FoodItem(
                                        imageFood: "ghorme",
                                        nameFood: "قورمه سبزی",
                                        descFood:
                                            "برنج ایرانی + ته چین + سبزی + ترشی + لیمو",
                                        ratingFood: 3.5,
                                        pricefood: 13000,
                                        person: "یک"),
                                  ],
                                ),
                                Center(
                                  child: Text("data"),
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
                      Text(
                        "دسته بندی",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                      Text(
                        "نقشه",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                      Text("           "),
                      Text(
                        "سفارشات",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                      Text(
                        "خروج",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ],
                  ),
                  color: Colors.deepPurple[200],
                ),
              )
            ],
          ),
        ));
  }
}
