import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ocrglossary/core/models/Bookmark.dart';
import 'package:ocrglossary/core/models/glossary.dart';
import 'package:ocrglossary/core/models/user.dart';
import 'package:ocrglossary/core/viewmodel/CRUDmodel.dart';
import 'package:ocrglossary/core/viewmodel/bookmarkModel.dart';
import 'package:ocrglossary/core/viewmodel/signupmodel.dart';
import 'package:ocrglossary/ui/view/userbookmarkScreen.dart';
import 'package:provider/provider.dart';

class UserGlossaryDetails extends StatefulWidget {
  final Glossary glossaryobj;

  UserGlossaryDetails({@required this.glossaryobj});

  @override
  _UserGlossaryDetailsState createState() => _UserGlossaryDetailsState();
}

class _UserGlossaryDetailsState extends State<UserGlossaryDetails> {
  bool _isFavorited = false;
  List<Bookmarks> book;
  List<Bookmarks> validbook;
  @override
  Widget build(BuildContext context) {
    final userprovider = Provider.of<SignUpModel>(context);
    var bookmarkobj = Provider.of<BookmarkModel>(context);
    Users a = userprovider.u;
    print(widget.glossaryobj.id);
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(25.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.glossaryobj.word,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.glossaryobj.term,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: (_isFavorited ? Icon(Icons.star) : Icon(Icons.star_border)),
              color: Colors.yellow[800],
              onPressed: () {
                print("Clicked");
                _toggleFavorite();
                var result = bookmarkobj.addBookmark(Bookmarks(
                  email: a.email,
                  word: widget.glossaryobj.word,
                  term: widget.glossaryobj.term,
                ));
                if (result != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserBookmarkScreen()),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _isFavorited = false;
      } else {
        _isFavorited = true;
      }
    });
  }
}
