import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ocrglossary/core/models/glossary.dart';
import 'package:ocrglossary/core/viewmodel/CRUDmodel.dart';
import 'package:ocrglossary/ui/widgets/mainDrawer.dart';
import 'package:ocrglossary/ui/view/ModifyGlossary.dart';
import 'package:provider/provider.dart';

class GlossaryDetails extends StatefulWidget {
  final Glossary glossaryobj;

  GlossaryDetails({@required this.glossaryobj});

  @override
  _GlossaryDetailsState createState() => _GlossaryDetailsState();
}

class _GlossaryDetailsState extends State<GlossaryDetails> {



  @override
  Widget build(BuildContext context) {
    final glossaryProvider = Provider.of<CRUDmodel>(context);

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
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}