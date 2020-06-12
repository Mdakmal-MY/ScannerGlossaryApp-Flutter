import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ocrglossary/core/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:ocrglossary/core/models/userImage.dart';
import 'package:ocrglossary/core/services/storageServices.dart';
import 'package:ocrglossary/core/viewmodel/basemodel.dart';
import 'package:ocrglossary/core/services/userprocessapi.dart';
import 'package:ocrglossary/locator.dart';
import 'package:ocrglossary/core/services/analyticsprocessapi.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';


class SignUpModel extends BaseModel{
  List<Users> userList;

  final UserProcessApi _authenticationService = locator<UserProcessApi>();
  final AnalyticsProcessApi _analyticsProcessApi = locator<AnalyticsProcessApi>();
  final StorageServices _storageServices = locator<StorageServices>();
  bool idstatus = false;
  bool loginstatus = false;
  Users u;

  Future signUp(Users data) async{
    setBusy(true);
    var result = await _authenticationService.singUpWithEmail(
        email: data.email,
        password: data.password,
        firstname: data.firstname,
        lastname: data.lastname,
        role: data.role,
    );
    print("Error signup $result");
      if(result == "true"){
        print("Masuk");
        await _analyticsProcessApi.logSignUp();
        idstatus = true;
        return result;
      }
      else{
        idstatus = false;
        print("Failed");
        return result;
      }

  }

  Future login({@required String email, @required String password}) async{
    var result = await _authenticationService.loginwithEmail(email: email, password: password);

    if(result != null && result != 'none'){
      loginstatus = true;
      u = _authenticationService.currentUser;

      return u;
    }
    else if(result == 'none'){
      Users a = new Users();
      a.role = "invalid";
      return a;
    }
    else{
      return null;
    }
  }

  Future<void> logOut() async{
    await _authenticationService.logoutNow();
    loginstatus = false;
  }

  Stream<QuerySnapshot> fetchUserData(){
    return _authenticationService.streamSearchAllUser();
  }


  Future removeUser(String id) async{
    await _authenticationService.removeDocument(id);
  }

//  Future ListStudent() async{
//    var result = _authenticationService.getUser(id);
//    return result;
//  }

  Future updateUser(Users data, String id) async{
    return _authenticationService.updateDocument(data.toJson(), id);
  }

  Future uploadProfile(File images, String id) async{
    return _storageServices.uploadImage(imageToUpload: images, title: id);
  }

  Stream<QuerySnapshot> EachUser(){
    print(u.id);
    return _authenticationService.streamAUser(u.id);
  }

//  Future viewProfile(String id)async{
//    return _storageServices.
//  }
}