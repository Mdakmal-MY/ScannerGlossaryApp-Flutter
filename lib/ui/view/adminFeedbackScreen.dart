import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ocrglossary/core/models/feedbackuser.dart';
import 'package:ocrglossary/core/viewmodel/feedbackModel.dart';
import 'package:provider/provider.dart';
import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminFeedbackScreen extends StatefulWidget{
  @override
  _AdminFeedbackScreenState createState() => _AdminFeedbackScreenState();
}

class _AdminFeedbackScreenState extends State<AdminFeedbackScreen>{
  List<FeedbackUser> feedsUser;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var feedbackProvider = Provider.of<FeedbackModel>(context);
    return Scaffold(
      appBar: AppBar(title: Text("User Feedback"),),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.jpg'),
              fit: BoxFit.fill
          ),
        ),
        height: 650,
        padding: EdgeInsets.all(14),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              StreamBuilder(
                stream: feedbackProvider.getFeedback(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                    if(snapshot.hasData){
                      feedsUser = snapshot.data.documents
                          .map((doc) => FeedbackUser.fromMap(doc.data))
                          .toList();
                      return ListView.builder(
                        itemCount: feedsUser.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (buildContext, index) {
                          return Bubble(
                            margin: BubbleEdges.only(top: 10),
                            stick: true,
                            nip: BubbleNip.leftTop,
                            color: Color.fromRGBO(225, 255, 199, 1.0),
                            child: ListTile(
                              title: Text('${feedsUser[index].Comment}', textAlign: TextAlign.left),
                              subtitle: Text('${feedsUser[index].email} ${feedsUser[index].Date}'),
                              enabled: true,
                              onTap: (){
                                print(feedsUser[index].Comment);
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context){
                                      return AlertDialog(
                                        title: Text('Delete Confirmation!'),
                                        content: Text("Are you sure to delete ${feedsUser[index].email} feedback ?"),
                                        actions: [
                                          FlatButton(
                                            child: Text("Yes"),
                                            onPressed: ()async{
                                              var result  = await feedbackProvider.deleteFeedback(snapshot.data.documents[index].documentID);
                                              Navigator.pop(context);
                                            },
                                          ),
                                          FlatButton(
                                            child: Text("No"),
                                            onPressed: (){
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    }
                                );
                              },
                            ),
                          );
                        },
                      );
                    }
                    else{
                      return Text('fetching');
                    }
                  }
              ),
              SizedBox(height: 15,),
            ],
          ),
        ),
      ),
    );
  }
}

