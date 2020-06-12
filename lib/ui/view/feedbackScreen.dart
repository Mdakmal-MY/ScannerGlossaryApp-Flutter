import 'package:ocrglossary/ui/widgets/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ocrglossary/core/viewmodel/feedbackModel.dart';
import 'dart:async';
import 'package:status_alert/status_alert.dart';

class FeedbackScreen extends StatefulWidget{
  @override
  FeedbackScreenState createState() => FeedbackScreenState();
}

class FeedbackScreenState extends State<FeedbackScreen> {

  final emailController = TextEditingController();
  final commentController = TextEditingController();
  bool validateComment = false;
  bool checkEmail = false;
  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  @override
  void dispose(){
    emailController.dispose();
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var FeedbackProvider = Provider.of<FeedbackModel>(context);
    return Scaffold(
        appBar: AppBar(title: Text("Feedback"),),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            height: 610,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background.jpg'),
                  fit: BoxFit.fill
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      FadeAnimation(1.8, Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, .2),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10)
                              )
                            ]
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[100]))
                              ),
                              child: TextField(
                                controller: emailController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Email",
                                    hintStyle: TextStyle(color: Colors.grey[400]),
                                    errorText: checkEmail?"Please Enter a Valid Email Address": null,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                controller: commentController,
                                maxLines: 8,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Comment",
                                    hintStyle: TextStyle(color: Colors.grey[400]),
                                    errorText: validateComment?"Please Leave a Comment":null,
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                      SizedBox(height: 30,),
                      FlatButton(
                        onPressed: () async{
                          setState(() {
                            if(commentController.text==null){
                              validateComment = true;
                            }
                            else if(commentController.text!=null){
                              validateComment = false;
                            }
                            if(validateEmail(emailController.text)==false){
                              checkEmail = true;
                            }
                            else if(validateEmail(emailController.text)==true){
                              checkEmail = false;
                            }
                          });
                          if(commentController.text!=null && emailController.text!=null && validateComment == false && checkEmail == false){
                            var result = await FeedbackProvider.sendFeedback(emailController.text, commentController.text);
                            if(result != null){
                              StatusAlert.show(
                                context,
                                duration: Duration(seconds: 4),
                                subtitle: 'Submitted',
                                configuration: IconConfiguration(icon: Icons.done),
                              );
                            }
                          }
                        },
                        color: Colors.blue,
                        padding: EdgeInsets.all(16),
                          child: Text("Send", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                      ),
//                      FadeAnimation(1.5, Text("Forgot Password?", style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}