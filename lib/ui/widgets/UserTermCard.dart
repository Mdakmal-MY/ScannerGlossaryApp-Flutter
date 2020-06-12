import 'package:flutter/material.dart';
import 'package:ocrglossary/core/models/glossary.dart';
import 'package:ocrglossary/ui/view/glossaryDetails.dart';
import 'package:ocrglossary/ui/view/userglossaryDetails.dart';

class UserTermCard extends StatelessWidget {
  final Glossary userglossaryDetails;

  UserTermCard({@required this.userglossaryDetails});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_) => UserGlossaryDetails(glossaryobj: userglossaryDetails)));
      },
      child: Card(
        elevation: 0,
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 10, 20),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      userglossaryDetails.word,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_right),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}