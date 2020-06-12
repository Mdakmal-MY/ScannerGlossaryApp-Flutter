import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:ocrglossary/core/models/user.dart';
import 'package:ocrglossary/core/services/analyticsprocessapi.dart';
import 'package:ocrglossary/locator.dart';

class UserProcessApi {
  final Firestore _db = Firestore.instance;
  final String path;
  CollectionReference ref;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final AnalyticsProcessApi _analyticsProcessApi = locator<AnalyticsProcessApi>();

  Users _currentUser;
  Users get currentUser => _currentUser;

  UserProcessApi(this.path){
    ref = _db.collection(path);
  }

  Future loginwithEmail({@required String email, @required
  String password}) async{
    try{
      var authResult = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
        if(authResult.user.isEmailVerified){
          await CurrentUser(authResult.user);
          await _analyticsProcessApi.logLogIn();
          print("Masuk  ${authResult.user}");
          return authResult;
        }else if(!authResult.user.isEmailVerified){
          return "none";
        }
      }
    catch(e){
      print("Errrors ${e.toString()}");
      return null;
    }
  }

  Future CurrentUser(FirebaseUser user) async{
    if(user !=null){
      _currentUser = await getUser(user.uid);
      print("Current ${_currentUser.role}");
      await _analyticsProcessApi.setUserProperties(uid: user.uid);
    }
  }

  Future getUser(String id) async{
    try{
      var userData = await ref.document(id).get();
      return Users.fromMap(userData.data);
    }catch(e){
      return e.message;
    }
  }

  Future createUser(Users user) async{
    try{
      await ref.document(user.id).setData(user.toJson());
    }
    catch(e){
      return e.message;
    }
  }

  Future singUpWithEmail(
      {
        @required String email,
        @required String password,
        @required String firstname,
        @required String lastname,
        @required String role,
      }) async{
    try{
      print(role);
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      if(!authResult?.toString().isEmpty){
      authResult.user.sendEmailVerification();
        await createUser(Users(
          id: authResult.user.uid,
          password: password,
          email: email,
          firstname: firstname,
          lastname: lastname,
          role: role,
        ));
      print("ERROR APAI MASA2");
      }
      print("ERROR APAI MASA3");
      return "true";
    }
    catch(e){
      print("ERROR APAI MASA");
      return e.message;
    }
  }

  Future<void> logoutNow() async{
    try{
       await _firebaseAuth.signOut();
    }
    catch(e){
      print(e.message);
    }
  }

  Stream<QuerySnapshot> streamSearchAllUser(){
    return ref.where('role', isEqualTo: 'student').snapshots();
  }

  Stream<QuerySnapshot> streamAUser(String id){
    return ref.where('id', isEqualTo: id).snapshots();
  }

  Future<void> removeDocument(String id){
    return ref.document(id).delete();
  }

  Future ListStudent() async{
    return ref.where('role', isEqualTo: 'student').snapshots();
  }

  Future<void> updateDocument(Map data, String id) async{

    try{
      var result = await _firebaseAuth.currentUser();
      await result.updatePassword(data['password']);
    }
    catch(e){
      print(e.toString());
    }
    return ref.document(id).updateData(data);
  }


}