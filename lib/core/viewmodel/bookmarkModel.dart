import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ocrglossary/core/models/Bookmark.dart';
import 'dart:async';
import 'package:ocrglossary/core/services/bookmarkApi.dart';
import 'package:ocrglossary/locator.dart';

class BookmarkModel extends ChangeNotifier{

  BookmarkApi _bookmarkApi = locator<BookmarkApi>();

  Future addBookmark(Bookmarks b) async{
    var result = _bookmarkApi.addDocument(b.toJson());
    return result;
  }

  Stream<QuerySnapshot> savedBookmark(String id){
    return _bookmarkApi.streamBookmarkCollection(id);
  }

  Stream<QuerySnapshot> verifyBookmark(String email, String id){
    return _bookmarkApi.streamVerifyCollection(email,id);
  }

  Future deleteBookmark(String id) async{
    return _bookmarkApi.removeDocument(id);
  }
}