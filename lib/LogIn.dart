import 'package:flutter/material.dart';
import 'package:food/FoodList.dart';
import 'AppData.dart' as AppData;
import 'package:http/http.dart' as http;

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController phoneController;
  TextEditingController passController;

  FocusNode phoneFocus;
  FocusNode passFocus;

  bool waitForServer = false;
  var txtError = "";

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    phoneController = TextEditingController();
    passController = TextEditingController();

    phoneFocus = FocusNode();
    passFocus = FocusNode();
  }

  @override
  void dispose() {
    phoneController.dispose();
    passController.dispose();

    phoneFocus.dispose();
    passFocus.dispose();

    super.dispose();
  }

  Widget txtFiled(TextEditingController controller, String labelName,
      IconData icon, FocusNode focusNode, FocusNode nextFocusNode) {
    return TextField(
      focusNode: focusNode,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(nextFocusNode);
      },
      controller: controller,
      decoration: InputDecoration(labelText: labelName, prefixIcon: Icon(icon)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("ورود"),
        backgroundColor: Color(0xff095857),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        color: Color(0xffE0F2F1),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              txtFiled(
                  phoneController, "تلفن همراه", Icons.phone, null, passFocus),
              Text(""),
              txtFiled(passController, "رمز عبور", Icons.vpn_key, null, null),
              Text(""),
              Text(""),
              Text(
                txtError,
                style: TextStyle(color: Colors.red),
              ),
              Center(
                child: waitForServer
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                            Theme.of(context).primaryColor),
                        backgroundColor: Theme.of(context).accentColor,
                      )
                    : null,
              ),
              Text(""),
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
                        onTap: () async {
                          setState(() {
                            txtError = "";
                          });
                          if (phoneController.text.isEmpty) {
                            setState(() {
                              txtError = "لطفا تلفن همراه خود را وارد کنید";
                            });
                          } else if (passController.text.length < 4) {
                            setState(() {
                              txtError = "رمز عبور حداقل 4 حرف می باشد";
                            });
                          } else {
                            setState(() {
                              waitForServer = true;
                            });
                            var link = "${AppData.BaseUrl}/logIn";
                            var data = {
                              "phone": phoneController.text,
                              "password": passController.text
                            };
                            var response = await http.post(Uri.encodeFull(link),
                                body: data);
                            if (response.statusCode == 200) {
                              setState(() {
                                waitForServer = false;
                              });
                              print(response.body);
                              if (response.body == "1") {
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text("شما با موفقیت وارد شدید"),
                                  backgroundColor: Colors.green,
                                ));

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FoodList()));
                              } else if (response.body == "0") {
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  backgroundColor: Colors.red,
                                  content:
                                      Text("شماره تلفن یا رمز عبور اشتباه است"),
                                ));
                              }
                            } else {
                              setState(() {
                                waitForServer = false;
                              });
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                backgroundColor: Colors.orange,
                                content: Text(
                                    "در ارتباط با سرور مشکلی پیش آمد،لطفا بعدا امتحان کنید"),
                              ));
                            }
                          }
                        },
                        child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: MediaQuery.of(context).size.height * 1,
                            color: Color(0xff09888A),
                            child: Text(
                              "تایید",
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
                          child: Icon(Icons.check_circle))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
