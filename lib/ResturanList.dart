import 'dart:convert';

import 'package:flutter/material.dart';
import 'AppData.dart' as AppData;
import 'package:http/http.dart' as http;

class ResturanList extends StatefulWidget {
  final List imgName;
  final List resturanName;

  const ResturanList({Key key, this.imgName, this.resturanName})
      : super(key: key);

  @override
  _ResturanListState createState() => _ResturanListState();
}

class _ResturanListState extends State<ResturanList> {
  List imgName;
  List resturanName;
  var initFuture;
  @override
  void initState() {
    super.initState();

    initFuture = getDataResturan();
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
    return FutureBuilder(
      future: getDataResturan(),
      builder: (context, snapShot) {
        if (snapShot.hasData) {
          return ResturanItem(snapShot.data);
        } else if (snapShot.hasError) {
          return Center(
            child: Text("برنامه با مشکل مواجه شده است لطفا بعدا امتحان کنید"),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Theme.of(context).primaryColor,
              valueColor: AlwaysStoppedAnimation(Theme.of(context).accentColor),
            ),
          );
        }
      },
    );
  }
}

class ResturanData {
  int resturanId;
  String banner;
  String name;
  String address;

  ResturanData({this.resturanId, this.banner, this.name, this.address});

  factory ResturanData.fromJson(Map<String, dynamic> json) {
    return ResturanData(
        resturanId: json["id"],
        banner: json["banner"],
        name: json["name"],
        address: json["address"]);
  }
}
