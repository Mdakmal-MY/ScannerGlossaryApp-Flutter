import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ocrglossary/core/models/user.dart';
import 'package:ocrglossary/core/models/userImage.dart';
import 'package:ocrglossary/core/services/storageServices.dart';
import 'package:ocrglossary/core/viewmodel/imageModel.dart';
import 'package:ocrglossary/core/viewmodel/signupmodel.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:status_alert/status_alert.dart';

class UserUpdateScreen extends StatefulWidget {
  @override
  _UserUpdateScreenState createState() => _UserUpdateScreenState();
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
class _UserUpdateScreenState extends State<UserUpdateScreen> {
  MaterialColor coreblackCustom = MaterialColor(0xFF272727, color);
  MaterialColor blackCustom = MaterialColor(0xFF1f3044, color);
  MaterialColor bgCustom = MaterialColor(0xFF2b814b, color);
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  final conpasswordController = TextEditingController();
  Users userObj = new Users();
  List <UserImage> uiObj;
  bool checkFname = false, checkLname = false , checkPass = false , checkComfirm = false;
  String imageLink;
  File imageProfile;

  @override
  void dispose(){
    firstNameController.dispose();
    lastNameController.dispose();
    addressController.dispose();
    passwordController.dispose();
    conpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<SignUpModel>(context);
    var userImageProvider = Provider.of<ImageModel>(context);
    userObj = userProvider.u;
    return Scaffold(
      backgroundColor: bgCustom,
      appBar: AppBar(
        title: Text("Update Account"),
      ),
      body: Container(
          margin: EdgeInsets.all(12),
          padding: EdgeInsets.all(12),
          color: blackCustom,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10,0, 0),
                  color: blackCustom,
                  child: Text("My Account",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),),
                ),
                SizedBox(height: (10),),
                Container(
                  width:  250,
                  height: 250,
                  child: StreamBuilder(
                    stream: userImageProvider.StreamUserImage(userObj.email),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if(snapshot.hasError){
                        return Text("Low Internet Please ");
                      }
                      else if(snapshot.hasData){
                        uiObj = snapshot.data.documents
                            .map((doc) =>UserImage.fromMap(doc.data))
                            .toList();
                        imageLink = uiObj[0].imageLink;
                        if(imageLink != "none") {
                          return GestureDetector(
                            child: CircleAvatar(
                              radius: 100,
                              child: ClipOval(
                                child: SizedBox(
                                    width: 250,
                                    height: 250,
                                    child: Image.network(imageLink,fit: BoxFit.fill,)),
                              ),
                            ),
                            onTap: () async {
                              imageProfile = await ImagePicker.pickImage(
                                  source: ImageSource.gallery);
                              if(imageProfile!=null){
                                CloudStorageResult result = await userProvider.uploadProfile(imageProfile, userObj.id);
                                await userImageProvider.updateUserImage(UserImage(id: userObj.email, imageLink: result.imageUrl), snapshot.data.documents[0].documentID);
                              }
                            },
                          );
                        }
                        else if(imageLink == "none"){
                          return GestureDetector(
                            child: CircleAvatar(
                              child: ClipOval(
                                child: Icon(Icons.person, size: 100,),
                              ),
                              radius: 100,
                            ),
                            onTap: () async {
                              imageProfile = await ImagePicker.pickImage(source: ImageSource.gallery);
                              if(imageProfile!=null){
                                CloudStorageResult result = await userProvider.uploadProfile(imageProfile, userObj.id);
                                await userImageProvider.updateUserImage(UserImage(id: userObj.email, imageLink: result.imageUrl), snapshot.data.documents[0].documentID);
                              }
                              },
                          );
                        }
                      }
                      else{
                        print("No data");
                      }
                    }
                  ),
                ),
                SizedBox(height: 20,),
                TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    labelText: "${userObj.email}",
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  enabled: false,

                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: TextField(
                        controller: firstNameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                            labelText: "First Name",
                            errorText: checkFname?"Please Enter a Valid First name": null,
                        ),
                      ),
                    ),
                    SizedBox(width: 5,),
                    Flexible(
                      flex: 1,
                      child: TextField(
                        controller: lastNameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                            labelText: "Last Name",
                            errorText: checkLname?"Please Enter a Valid Last Name": null,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    labelText: "Password",
                    errorText: checkPass?"Password Length Should be more than 6 character": null,
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: conpasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    labelText: "Confirm Password",
                    errorText: checkComfirm?"Password Invalid": null,
                  ),
                ),
                SizedBox(height: 10,),
                FlatButton(
                  padding: EdgeInsets.all(16),
                  child: Text("Update Account"),
                  onPressed: () async{
                    setState(()  {
                      validateFirstname(firstNameController.text);
                      validatePassword(passwordController.text, conpasswordController.text );
                      validateLastname(lastNameController.text);
                    });

                    if((firstNameController.text.isNotEmpty && lastNameController.text.isNotEmpty) && (passwordController.text.isNotEmpty && conpasswordController.text.isNotEmpty)
                        && (passwordController.text == conpasswordController.text) && (passwordController.text.length>6) && (conpasswordController.text.length>6)){
                      var result  = await userProvider.updateUser(Users(
                        email: userObj.email,
                        firstname: firstNameController.text,
                        lastname: lastNameController.text,
                        password: conpasswordController.text,
                        id: userObj.id,
                        role: userObj.role,
                      ), userObj.id);
                      if(result!=null){
                          StatusAlert.show(
                            context,
                            duration: Duration(seconds: 2),
                            subtitle: 'Submitted',
                            configuration: IconConfiguration(icon: Icons.done),
                          );
                      }
                    }
                    else{
                      print("ERror");
                    }
                  },
                  color: Color.fromRGBO(235, 242, 3 , 3),
                ),
              ],
            ),
          ),
      ),
    );
  }

  void validatePassword(String confirmPass, String Passwords){
    if((confirmPass == Passwords) && (confirmPass.isNotEmpty && Passwords.isNotEmpty) && (confirmPass.length>5 && Passwords.length>5)){
      checkComfirm = false;
      checkPass = false;
      }
    else{
      checkComfirm = true;
      checkPass = true;
    }
  }

  void validateFirstname(String fname){
    if(fname.isNotEmpty){
      checkFname = false;
    }
    else{
      checkFname = true;
    }
  }

  void validateLastname(String lname){
    if(lname.isNotEmpty){
      checkLname = false;
    }
    else{
      checkLname = true;
    }
  }

  void reloadpropic(CloudStorageResult uploadedImages){
    setState(() {
      print(uploadedImages.imageUrl);
      imageLink = uploadedImages.imageUrl;
    });

  }
}
