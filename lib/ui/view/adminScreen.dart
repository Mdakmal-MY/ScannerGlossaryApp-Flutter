import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ocrglossary/core/models/glossary.dart';
import 'package:ocrglossary/core/viewmodel/CRUDmodel.dart';
import 'package:ocrglossary/ui/widgets/mainDrawer.dart';
import 'package:provider/provider.dart';

class adminScreen extends StatefulWidget{
  @override
  _adminScreenState createState() => _adminScreenState();
}

Map<int, Color> color ={
  50:Color.fromRGBO(136,14,79, .1),
  100:Color.fromRGBO(136,14,79, .2),
  200:Color.fromRGBO(136,14,79, .3),
  300:Color.fromRGBO(136,14,79, .4),
  400:Color.fromRGBO(136,14,79, .5),
  500:Color.fromRGBO(136,14,79, .6),
  600:Color.fromRGBO(136,14,79, .7),
  700:Color.fromRGBO(136,14,79, .8),
  800:Color.fromRGBO(136,14,79, .9),
  900:Color.fromRGBO(136,14,79, 1),
};

class _adminScreenState extends State<adminScreen>{
  MaterialColor blackCustom = MaterialColor(0xFF1f3044, color);
  final _formKey = GlobalKey<FormState>();
  String id;
  String title;
  String subtitle;
  String hintword = "word";
  String hintterm = "Term";
  bool enabledText = true;
  bool changeColor = false;
  List<Glossary> glossaryobj;
  @override
  Widget build(BuildContext context){
    var glossaryProvider = Provider.of<CRUDmodel>(context);
    return Scaffold(
      backgroundColor: blackCustom,
      appBar: AppBar(
        title: Text("Manage Glossary"),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.white,
                child: TextFormField(
                  enabled: enabledText,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '$hintword',
                      filled: changeColor,
                      hintStyle: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter words';
                      }
                    },
                    onSaved: (value) => title = value
                ),
              ),
              Container(
                padding: EdgeInsets.all(12),
                color: Colors.white,
                height: 120,
                child: TextFormField(
                  maxLines: 5,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '$hintterm',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter terms';
                      }
                    },
                    onSaved: (value) => subtitle = value
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton.icon(
                    splashColor: Colors.blue,
                    onPressed: () async{
                      setState(() {
                        enabledText = true;
                        changeColor = false;
                      });
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        print("$subtitle");
                        print("$title");
                        await glossaryProvider.addGlossary(Glossary(word: title, term: subtitle));
                      }
                    },
                    icon: Icon(Icons.add),
                    label: Text('Add', style: TextStyle(color: Colors.white)),
                    color: Colors.blue,
                  ),
                  RaisedButton.icon(
                    onPressed: () async{
                      await glossaryProvider.removeGlossary(id);
                    },
                    icon: Icon(Icons.delete),
                    label: Text("Delete",style: TextStyle(color: Colors.white),),
                    color: Colors.red,

                  ),
                  RaisedButton.icon(onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        var result = await glossaryProvider.updateGlossary(Glossary(word: title,term: subtitle),id);
                        print(result);
                      }


                  },
                    icon: Icon(Icons.update),
                    label: Text("Update", style: TextStyle(color: Colors.white),),
                    color: Colors.amber,
                  ),

                ],
              ),
              SizedBox(height: 20,),
              Expanded(
                child: Container(
                  color: Colors.white,
                  height: 280,
                  child: StreamBuilder(
                      stream: glossaryProvider.fetchGlossaryAsStream(),
                      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                        if(snapshot.hasData){
                          glossaryobj = snapshot.data.documents
                              .map((doc) => Glossary.fromMap(doc.data, doc.documentID))
                              .toList();
                          if(glossaryobj!=null){
                            print(glossaryobj.toList().toString());
                          }
                          return ListView.builder(
                            itemCount: glossaryobj.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (buildContext, index) {
                              return ListTile(
                                title: Text('${glossaryobj[index].word}', style: TextStyle(
                                  color: Colors.black,
                                ),),
                                dense: true,
                                enabled: true,
                                selected: true,
                                onTap: (){
                                  setState(() {
                                    hintword = glossaryobj[index].word;
                                    hintterm = glossaryobj[index].term;
                                    title = glossaryobj[index].word;
                                    subtitle = glossaryobj[index].term;
                                    id = glossaryobj[index].id;
                                    changeColor = true;
                                  });
                                },
                              );
                            },
                          );
                        }
                        else{
                          return Text('fetching');
                        }
                      }
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}