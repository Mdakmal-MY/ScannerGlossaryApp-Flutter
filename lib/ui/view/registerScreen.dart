import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ocrglossary/core/models/userImage.dart';
import 'package:ocrglossary/core/viewmodel/imageModel.dart';
import 'package:ocrglossary/core/viewmodel/signupmodel.dart';
import 'package:provider/provider.dart';
import 'package:ocrglossary/core/models/user.dart';

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

class RegisterScreen extends StatefulWidget{
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>{
  final _formKey = GlobalKey<FormState>();
  String emails;
  String passwords;
  String firstname;
  String lastname;
  String role = "student";
  MaterialColor blackCustom = MaterialColor(0xFF1f3044, color);
  MaterialColor bgCustom = MaterialColor(0xFF2b814b, color);
  @override
  Widget build(BuildContext context){
    var userprovider = Provider.of<SignUpModel>(context);
    var imageprovider = Provider.of<ImageModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("New User",
        textAlign: TextAlign.center,
        ),
        elevation: 0,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color:blackCustom,
            ),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Container(
                  height: 500,
                  padding: EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(height: 20,),
                      Text("Membership Registration",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 40,
                        color: Colors.white,
                      ),),
                      SizedBox(height: 30,),
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: TextFormField(
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.perm_contact_calendar),
                                  fillColor: Colors.grey[200],
                                  filled: true,
                                  contentPadding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                                  labelText: "First Name",
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value){
                                  if(value.isEmpty){
                                    return 'Please Enter Your Firstname';
                                  }
                                },
                                onSaved:(value) => firstname = value
                            ),
                          ),
                          SizedBox(width: 10,),
                          Flexible(
                            child: TextFormField(
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.perm_contact_calendar),
                                  fillColor: Colors.grey[200],
                                  filled: true,
                                  contentPadding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                                  labelText: "Last Name",
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value){
                                  if(value.isEmpty){
                                    return 'Please Enter Your LastName';
                                  }
                                },
                                onSaved:(value) => lastname = value
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            fillColor: Colors.grey[200],
                            filled: true,
                            contentPadding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                            border: OutlineInputBorder(),
                            labelText: "Email Address",
                          ),
                          validator: (value){
                            if(value.isEmpty){
                              return 'Please Key in Valid Email Address';
                            }
                          },
                          onSaved:(value) => emails = value
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            fillColor: Colors.grey[200],
                            filled: true,
                            contentPadding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                            border: OutlineInputBorder(),
                            labelText: "Password",
                          ),
                          validator: (value){
                            if(value.isEmpty){
                              return 'Please Enter Your Password';
                            }
                          },
                          onSaved:(value) => passwords = value
                      ),
                      SizedBox(height: 10),
                      Flexible(
                        child: FlatButton(
                          padding: EdgeInsets.all(12),
                          color: bgCustom,
                          textColor: Colors.white,
                          onPressed: () async{
                            if(_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              var result  = await userprovider.signUp(Users(email: emails, password: passwords, firstname: firstname, lastname: lastname, role: role));
                              print("Resultt $result");
                              print("Resultt ${userprovider.idstatus}");
                              if(userprovider.idstatus == true){
                                var addImagepro = await imageprovider.addImage(UserImage(id:emails, imageLink: "none"));
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context){
                                      return AlertDialog(
                                        title: Text("Email Verification"),
                                        content: Text("Please check your email to proceed"),
                                      );
                                    }
                                );
                              }
                              else if(userprovider.idstatus == false){
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context){
                                      return AlertDialog(
                                        title: Text("Failed"),
                                        content: Text("$result"),
                                      );
                                    }
                                );
                              }
                            }
                          },
                          child: Text("Register"),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}