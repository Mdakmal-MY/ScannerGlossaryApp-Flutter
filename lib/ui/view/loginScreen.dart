import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ocrglossary/core/models/user.dart';
import 'package:ocrglossary/ui/routepath.dart';
import 'package:ocrglossary/ui/view/adminMainScreen.dart';
import 'package:provider/provider.dart';
import 'package:ocrglossary/core/viewmodel/signupmodel.dart';
import 'package:ocrglossary/ui/widgets/LoadingScreen.dart';

class LoginScreen extends StatefulWidget{
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
Map<int, Color> color ={
  50:Color.fromRGBO(136,14,79, .1),
  100:Color.fromRGBO(136,14,79, .2),
  200:Color.fromRGBO(136,14,79, .3),
  300:Color.fromRGBO(136,14,79, .4),
  400:Color.fromRGBO(136,14,79, .5),
  500:Color.fromRGBO(136,14,79, .6),
  600:Color.fromRGBO(136,14,79, .7),
  700:Color.fromRGBO(136,14,79, .8),
  800:Color.fromRGBO(136,14,79, .9),
  900:Color.fromRGBO(136,14,79, 1),
};
class _LoginScreenState extends State<LoginScreen>{
  MaterialColor blackCustom = MaterialColor(0xFF1f3044, color);
  MaterialColor bgCustom = MaterialColor(0xFF2b814b, color);
  final _formkey = GlobalKey<FormState>();
  String email;
  String password;
  bool loadcomplete = false;
  @override
  Widget build(BuildContext context){
    var userprovider = Provider.of<SignUpModel>(context);
    return loadcomplete? LoginScreen():Scaffold(
      backgroundColor: bgCustom,
      appBar: AppBar(title: Text("Login"),
      elevation: 0
        ,),
      body: Form(
          key: _formkey,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color:blackCustom,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: bgCustom,
                        ),
                        padding: EdgeInsets.all(12),
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 60,
                              child: ClipOval(
                                child: SizedBox(
                                  height: 220,
                                  width: 220,
                                  child: Image.asset("assets/images/FYP.png"),
                                  ),
                                ),
                            ),
                            SizedBox(height: 15,),
                            Text("Scanner Glossary Dictionary For Software Engineering Student",
                              textAlign: TextAlign.center,
                              style:TextStyle(
                               fontWeight: FontWeight.w300,
                               fontSize: 25,
                               color: Colors.white,

                              ),),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            prefixIcon: Icon(Icons.email),
                            contentPadding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                            labelText: "Email Address",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value){
                            if(value.isEmpty){
                              return 'Please Fill the correct email address';
                            }
                          },
                          onSaved: (value) => email = value ,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            prefixIcon: Icon(Icons.lock),
                            contentPadding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                            border: OutlineInputBorder(),
                            labelText: "Password",
                          ),
                          validator: (value){
                            if(value.isEmpty){
                              return 'Please Fill Correct Password';
                            }
                          },
                          onSaved: (value) => password = value ,
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                        margin: EdgeInsets.all(10),
                        child: FlatButton(
                          padding: EdgeInsets.all(15),
                          color: Colors.white,
                          splashColor: Colors.green, 
                          child: Text("Login"),
                          onPressed: () async {
                            if(_formkey.currentState.validate()){
                              _formkey.currentState.save();
                              setState(() {
                                loadcomplete = true;
                              });
                              Users result = await userprovider.login(email: email, password: password);
                              print('TEST $result');
                              if(result != null){
                                setState(() {
                                  loadcomplete = false;
                                });
                                print("${result.role}");
                                print("$email");
                                print("$password");
                                if(result.role == "student"){
                                  Navigator.pop(context);
                                  Navigator.pushNamed(context, RoutePath.usermainpath);
                                }
                                else if(result.role == "admin"){
                                  Navigator.pop(context);
                                  Navigator.pushNamed(context, RoutePath.admindashboardpath);
                                }
                                else if(result.role == "invalid"){
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context){
                                        return AlertDialog(
                                          title: Text("Login Failed"),
                                          content: Text("Email Not Verified"),
                                        );
                                      }
                                  );
                                }
                              }
                              else if(result == null){
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context){
                                      return AlertDialog(
                                        title: Text("Login Failed"),
                                        content: Text("Invalid Email or password"),
                                      );
                                    }
                                );
                                setState(() {
                                  loadcomplete = false;
                                });
                              }
                            }
                          },
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(width: 10,),
                          Expanded(
                              child: Divider(
                                thickness: 3,
                                endIndent: 10,
                                color: Colors.white,
                              )
                          ),
                          Text("or", style: TextStyle(
                            color: Colors.white,
                          ),),
                          Expanded(
                              child: Divider(
                                thickness: 3,
                                indent: 10,
                                color: Colors.white,
                              )
                          ),
                          SizedBox(width: 10,),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
                        margin: EdgeInsets.all(10),
                        child: FlatButton(
                          padding: EdgeInsets.all(15),
                          color: bgCustom,
                          textColor: Colors.white,
                          onPressed: (){
                            Navigator.pop(context);
                            Navigator.pushNamed(context, RoutePath.registerpath);
                          },
                          child: Text("Register"),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],

        ),
      ),
    );
  }
}