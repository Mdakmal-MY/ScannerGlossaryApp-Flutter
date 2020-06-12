import 'package:flutter/material.dart';
import 'package:ocrglossary/core/models/glossary.dart';
import 'package:ocrglossary/core/viewmodel/CRUDmodel.dart';
import 'package:provider/provider.dart';


class ModifyGlossary extends StatefulWidget {
  final Glossary glossaryobj;

  ModifyGlossary({@required this.glossaryobj});

  @override
  _ModifyGlossaryState createState() => _ModifyGlossaryState();
}

class _ModifyGlossaryState extends State<ModifyGlossary> {
  final _formKey = GlobalKey<FormState>();
  String title ;
  String subtitle ;

  @override
  Widget build(BuildContext context) {
    final glossaryProvider = Provider.of<CRUDmodel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Modify Glossary Details'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                  initialValue: widget.glossaryobj.word,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Title',
                    fillColor: Colors.grey[300],
                    filled: true,
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Glossary Title';
                    }
                  },
                  onSaved: (value) => title = value
              ),
              SizedBox(height: 16,),
              TextFormField(
                  initialValue: widget.glossaryobj.word,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'SubTitle',
                    fillColor: Colors.grey[300],
                    filled: true,
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Glossary Title';
                    }
                  },
                  onSaved: (value) => subtitle = value
              ),
              RaisedButton(
                splashColor: Colors.red,
                onPressed: () async{
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    await glossaryProvider.updateGlossary(Glossary(word: title,term: subtitle),widget.glossaryobj.id);
                    Navigator.pop(context) ;
                  }
                },
                child: Text('Modify Now', style: TextStyle(color: Colors.white)),
                color: Colors.blue,
              )

            ],
          ),
        ),
      ),
    );
  }
}