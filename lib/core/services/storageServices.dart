import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:ocrglossary/core/models/userImage.dart';

class StorageServices {

  final Firestore _db = Firestore.instance;
  final String path;
  CollectionReference ref;

  StorageServices(this.path){
    ref = _db.collection(path);
  }

  Stream<QuerySnapshot> streamUserImage(String id){
    return ref.where('id', isEqualTo: id).snapshots();
  }

  Future<DocumentReference> addImage(Map data)  {
    ref.add(data);
  }

  Future<void> updateImage(Map data,String id){
    return ref.document(id).updateData(data);
  }

  Future<CloudStorageResult> uploadImage({
    @required File imageToUpload,
    @required String title,
  }) async {


    String imageFileName = title;

    final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(imageFileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(imageToUpload);
    StorageTaskSnapshot storageSnapshot = await uploadTask.onComplete;
    var downloadUrl = await storageSnapshot.ref.getDownloadURL();

    if (uploadTask.isComplete) {
      var url = downloadUrl.toString();
      return CloudStorageResult(
        imageUrl: url,
        imageFileName: imageFileName,
      );
    }

    return null;
  }

  Future deleteImage(String imageFileName) async {
    final StorageReference firebaseStorageRef =
    FirebaseStorage.instance.ref().child(imageFileName);

    try {
      await firebaseStorageRef.delete();
      return true;
    } catch (e) {
      return e.toString();
    }
  }

}

class CloudStorageResult {
  final String imageUrl;
  final String imageFileName;

  CloudStorageResult({this.imageUrl, this.imageFileName});
}