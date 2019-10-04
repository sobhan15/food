import 'package:flutter/material.dart';
import 'package:food/LogIn.dart';
import 'package:food/SignUp.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          child: Image.asset(
            "images/wb.jpg",
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 1,
            fit: BoxFit.fitHeight,
          ),
        ),
        Container(
          color: Colors.black45,
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(
                  "به برنامه ---- \n خوش آمدید",
                  style: TextStyle(color: Colors.white, fontSize: 35),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
              ),
              Transform(
                transform: Matrix4.skew(-0.4, 0),
                child: Container(
                  margin: EdgeInsets.only(bottom: 15),
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1)),
                  height: 40,
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => LogIn()));
                        },
                        child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: MediaQuery.of(context).size.height * 1,
                            color: Color(0xff09888A),
                            child: Text(
                              "ورود",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            )),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 1,
                        color: Color(0xff095857),
                        width: 10,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.158,
                          alignment: Alignment.center,
                          height: 40,
                          color: Colors.white70,
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 20,
                          ))
                    ],
                  ),
                ),
              ),
              Transform(
                transform: Matrix4.skew(-0.4, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1)),
                  height: 40,
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        },
                        child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: MediaQuery.of(context).size.height * 1,
                            color: Color(0xff09888A),
                            child: Text(
                              "ثبت نام",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            )),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 1,
                        color: Color(0xff095857),
                        width: 10,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.158,
                          alignment: Alignment.center,
                          color: Colors.white70,
                          height: MediaQuery.of(context).size.height * 1,
                          child: Icon(Icons.person_add))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
