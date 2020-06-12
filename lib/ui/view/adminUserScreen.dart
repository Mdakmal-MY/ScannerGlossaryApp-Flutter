import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ocrglossary/core/services/userprocessapi.dart';
import 'package:ocrglossary/core/viewmodel/signupmodel.dart';
import 'package:provider/provider.dart';
import 'package:ocrglossary/core/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminUserScreen extends StatefulWidget{
  @override
  _AdminUserScreenState createState ()=> _AdminUserScreenState();
}


class _AdminUserScreenState extends State<AdminUserScreen>{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final SignUpModel _studentModel = SignUpModel();
  List<Users> userObj;
  var totalUser = 0;
  String uid = '';
  String selectedName = '';
  String textStatus = '';
  String tempEmail = '';
  String tempPassword = '';
  List<String> status;
// cannot verified each function because firebase plan are free limited for 15 times verified
//   Future<void> checkVerificationEmail(String email, String password) async {
//    try{
//      var authResult = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
//
//      if(authResult != null){
//        if(authResult.user.isEmailVerified){
//          setState(() {
//            textStatus =  "Verified";
//          });
//        }else if(!authResult.user.isEmailVerified){
//          setState(() {
//            textStatus =  "Not Verified";
//          });
//        }
//      }
//    }
//    catch(e){
//      print(e.message);
//    }
//
//  }

//  Future<int> allUser() async{
//     try{
//       var  totalUStudent = await _studentModel.ListStudent();
//       return totalUStudent;
//     }
//     catch(e){
//       return e.message;
//     }
//  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final userprovider = Provider.of<SignUpModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("User List"),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: StreamBuilder(
                stream: userprovider.fetchUserData(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if(!snapshot.hasData){
                    return Text('loading please wait..');
                  }
                  else{
                    userObj = snapshot.data.documents
                        .map((doc) => Users.fromMap(doc.data))
                        .toList();
//                    onloadWidget(userObj.length);
                    return ListView.builder(
                      itemCount: userObj.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (buildContext, index) {
                        return ListTile(
                          leading: Icon(Icons.account_circle),
                          title: Text('${userObj[index].firstname}',style: TextStyle(
                            color: Colors.black,
                          ),),
                          subtitle: Text('${userObj[index].email}',style: TextStyle(
                            color: Colors.blue,
                          ),),
                          dense: true,
                          enabled: true,
                          selected: true,
                          trailing: Column(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          ),
                          onTap: (){
                            setState(() {
                              uid = userObj[index].id;
                              selectedName = userObj[index].firstname;
                            });
                            return Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text('User ${userObj[index].firstname} Selected'),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 10,),
            RaisedButton(
              padding: EdgeInsets.all(20),
                color: Colors.red,
                onPressed: () async {
                  var result = await userprovider.removeUser(uid);
                  print(result);
                  if(result!=null){
                    print(result);
                    showDialog(
                        context: context,
                        builder: (BuildContext context){
                          return AlertDialog(
                            title: Text('Successfully Deleted !'),
                            content: Text("$selectedName"),
                          );
                        }
                    );
                  }
                },
                child:Text('Delete',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),),
            ),
          ],
        ),
      )
    );
    }
//  void onloadWidget(var val) {
//    setState(() => totalUser = userObj.length);
//  }
}