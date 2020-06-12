import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ocrglossary/core/models/Bookmark.dart';
import 'package:ocrglossary/core/models/user.dart';
import 'package:ocrglossary/core/viewmodel/bookmarkModel.dart';
import 'package:ocrglossary/core/viewmodel/signupmodel.dart';
import 'package:ocrglossary/ui/widgets/userDrawer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class UserBookmarkScreen extends StatefulWidget {
  @override
  _UserBookmarkScreenState createState() => _UserBookmarkScreenState();
}

class _UserBookmarkScreenState extends State<UserBookmarkScreen> {
  Users userobj = new Users();
  List<Bookmarks> bookobj;
  bool _isFavorited = true;

  @override
  Widget build(BuildContext context) {
    var bookmarkobj = Provider.of<BookmarkModel>(context);
    var userprovideobj = Provider.of<SignUpModel>(context);
    userobj = userprovideobj.u;

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Bookmark"),
      ),
      drawer: UserDrawer(),
      body: Container(
        child: StreamBuilder(
            stream: bookmarkobj.savedBookmark(userobj.email),
            // ignore: missing_return
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                bookobj = snapshot.data.documents
                    .map((doc) => Bookmarks.fromMap(doc.data))
                    .toList();
                return ListView.builder(
                  itemCount: bookobj.length,
                  itemBuilder: (context, index) {
                    if (bookobj == null) {
                      return Text("No Bookmark");
                    } else {
                      return ListTile(
                        leading: IconButton(
                            icon: (_isFavorited
                                ? Icon(Icons.star)
                                : Icon(Icons.star_border)),
                            color: Colors.yellow[800],
                            onPressed: () {
                              _toggleFavorite();
                            }),
                        title: Text('${bookobj[index].word}'),
                        subtitle: Text('${bookobj[index].term}',
                        textAlign: TextAlign.justify,
                        ),
                        dense: true,
                        enabled: true,
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Delete Bookmark"),
                                    content: Text(
                                        "Would you like to delete ${bookobj[index].word} ?"),
                                    actions: [
                                      FlatButton(
                                        child: Text("Yes"),
                                        onPressed: () async {
                                          await bookmarkobj.deleteBookmark(snapshot.data.documents[index].documentID);
                                          Navigator.pop(context);
                                        },
                                      ),
                                      FlatButton(
                                        child: Text("No"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                        ),
                      );
                    }
                  },
                );
              } else if(!snapshot.hasData || snapshot.data.documents.isEmpty) {
                return Container(
                  height: 200,
                  child: SpinKitPumpingHeart(
                    size: 100,
                    color: Colors.red,
                  ),
                );
              }
            }
            ),
      ),
    );
  }

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _isFavorited = true;
      } else {
        _isFavorited = true;
      }
    });
  }
}
