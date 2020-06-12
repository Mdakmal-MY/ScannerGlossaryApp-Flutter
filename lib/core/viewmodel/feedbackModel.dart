import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:ocrglossary/core/services/FeedbackApi.dart';
import 'package:ocrglossary/locator.dart';
import 'package:ocrglossary/core/models/feedbackuser.dart';

class FeedbackModel extends ChangeNotifier{

  FeedbackApi _feedbackApi = locator<FeedbackApi>();

  Future sendFeedback(String email, String Comment) async{
    var date = DateTime.now();
    String validdate = "${date.day}/${date.month}/${date.year} - ${date.hour}:${date.minute}";
    FeedbackUser obj = new FeedbackUser(email: email, Comment: Comment, Date: validdate);
    var result = await _feedbackApi.addDocument(obj.toJson());
    return result;
  }

  Stream<QuerySnapshot> getFeedback(){
    return _feedbackApi.streamFeedbackCollection();
  }

  Future deleteFeedback(String id) async{
    return _feedbackApi.removeDocument(id);
  }
}