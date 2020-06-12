import 'package:flutter/material.dart';
import 'package:ocrglossary/core/models/glossary.dart';
import 'package:ocrglossary/ui/view/glossaryDetails.dart';

class TermCard extends StatelessWidget {
  final Glossary glossaryDetails;

  TermCard({@required this.glossaryDetails});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_) => GlossaryDetails(glossaryobj: glossaryDetails)));
      },
      child: Card(
        elevation: 0,
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20,20, 10, 20),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      glossaryDetails.word,
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