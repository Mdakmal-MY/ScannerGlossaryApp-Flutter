import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ocrglossary/core/models/glossary.dart';
import 'package:provider/provider.dart';
import 'package:ocrglossary/core/viewmodel/CRUDmodel.dart';
import 'package:ocrglossary/ui/widgets/mainDrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ocrglossary/ui/widgets/TermCard.dart';
import 'package:flushbar/flushbar.dart';

class homeScreen extends StatefulWidget{

  @override

  _homeScreenState createState() => _homeScreenState();
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
class _homeScreenState extends State<homeScreen>{
  MaterialColor colorCustom = MaterialColor(0xFF272727, color);
  List<Glossary> glossaryobj;
  String name = "";
  int _currentIndex = 0 ;
  File imageSelect;
  List<Glossary> searchList = List<Glossary>();
  bool isImage = false;
  String itsVal = "";
  List<String> outputLine;

  void _onTapItem(int index){
    setState(() {
      isImage = false;
      _currentIndex = index;
    });
    if(index == 0){
      pickImageCamera();
    }
    else{
      pickImageGallery();
    }

  }
  @override
  Widget build(BuildContext context){
    final glossaryProvider = Provider.of<CRUDmodel>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Container(
          alignment: Alignment(0.0,0.0),
          height: 40,
          child: TextField(
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
            onChanged: (value) => searchNow(value),
            decoration: InputDecoration(
              hoverColor: Colors.lightGreen[900],
              focusColor: Colors.lightGreen[700],
              filled: true,
              labelText: "Search",
              hintText: "Search",
            ),
          ),
        ),
      ),
      drawer:appDrawer(),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
            ),
            Expanded(
              child: Container(
                color: Colors.grey[100],
                child: StreamBuilder(
                    stream: glossaryProvider.searchData(name),
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
                          itemBuilder: (buildContext, index) =>
                              TermCard(glossaryDetails: glossaryobj[index]),
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
      bottomNavigationBar:BottomNavigationBar(

        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            title: Text(''),
          ),
        ],
        currentIndex: _currentIndex,
        iconSize: 28,
        backgroundColor: colorCustom,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.green[800],
        onTap: _onTapItem,
      ),
    );
  }

  Future pickImageGallery() async{
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageSelect = tempImage;
      itsVal = "";
      name = "";
      searchList.clear();
      readText();
    });
  }

  Future pickImageCamera() async{
    var tempImage = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      imageSelect = tempImage;
      itsVal = "";
      name = "";
      searchList.clear();
      readText();
    });
  }

  Future readText() async{
        FirebaseVisionImage imageText = FirebaseVisionImage.fromFile(imageSelect);
        TextRecognizer recognizerText = FirebaseVision.instance.textRecognizer();
        VisionText readText = await recognizerText.processImage(imageText);
        for (TextBlock block in readText.blocks) {
          for (TextLine line in block.lines) {
            itsVal += "${line.text} \n";
            for (TextElement words in line.elements) {
              setState(() {
                searchList.add((Glossary(word: words.text)));
              });
            }

          }
        }
        recognizerText.close();
        compareText();
        searchNow(name);
  }



  Future compareText() async{
    for(Glossary findword in searchList){
      for(Glossary availableword in glossaryobj){
        if(findword.word==availableword.word){
          print(availableword.word);
          setState(() {
            name = findword.word;
            isImage = true;
          });
          break;
        }
      }
    }
      showImage();



  }

  void searchNow(String value){
    setState(() {
      name = value.trim();
    });
  }

  Widget getTextWidgets(String strings)
  {
    LineSplitter ls = new LineSplitter();
    outputLine = ls.convert(strings);
    List<Widget> list = new List<Widget>();
    for(var i = 0; i < outputLine.length; i++){
      list.add(Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent)
          ),
          child: new Text(outputLine[i],)));
    }
    return  SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:Column(
        children: list));
  }

  Widget showImage(){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return Dialog(
            child: Container(
              height: 450,
              width: 400,
              child: getTextWidgets(itsVal),
            ),
          );
        }
    );
    if(isImage) {
      Flushbar(
        title: "Image Segmentation",
        message: "Word Found $name",
        duration: Duration(seconds: 8),
      )..show(context);
    }
    else{
      Flushbar(
        title: "Image Segmentation",
        message: "Word Not Found",
        duration: Duration(seconds: 8),
      )..show(context);
    }
  }
}

