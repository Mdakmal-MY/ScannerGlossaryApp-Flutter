import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:ocrglossary/core/models/userImage.dart';
import 'package:ocrglossary/core/services/storageServices.dart';
import '../../locator.dart';

class ImageModel extends ChangeNotifier{

  final StorageServices _storageServices = locator<StorageServices>();

  Future addImage(UserImage data) async{
    var result = await _storageServices.addImage(data.toJson());
    return result;
  }

  Stream<QuerySnapshot> StreamUserImage(String email){
    return _storageServices.streamUserImage(email);
  }

  Future updateUserImage(UserImage data, String id) async{
    return _storageServices.updateImage(data.toJson(), id);
  }

}