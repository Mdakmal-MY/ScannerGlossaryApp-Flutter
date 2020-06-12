import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ocrglossary/core/models/user.dart';
import 'package:ocrglossary/core/viewmodel/signupmodel.dart';
import 'package:ocrglossary/ui/routepath.dart';
import 'package:provider/provider.dart';
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
class appDrawer extends StatelessWidget {
  List<Users> uObj;
  @override
  Widget build(BuildContext context) {
    var userprovider = Provider.of<SignUpModel>(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          SizedBox(height: 30),
          StreamBuilder(
            stream: userprovider.EachUser(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if(snapshot.hasData) {
                uObj = snapshot.data.documents
                    .map((doc) => Users.fromMap(doc.data)).toList();
                return ListView.builder(
                    itemCount: uObj.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (buildContext, index) {
                      return Text(
                        "Welcome ${uObj[index].firstname}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      );
                    }
                );
              }
              else{
                print("NO DATA EACH USER");
              }
            },
          ),
          SizedBox(height: 10),
          createDrawerItem(
            icon: Icons.home,
            text: "Dashboard",
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, RoutePath.admindashboardpath);
            },
          ),
          Divider(
            thickness: 5,
          ),
          createDrawerItem(
            icon: Icons.account_box,
            text: "User",
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
            child:createDrawerItem(
              icon: Icons.filter_vintage,
              text: "User Management",
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, RoutePath.adminuserpath);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
            child:createDrawerItem(
              icon: Icons.textsms,
              text: "User Feedback",
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, RoutePath.adminFeedbackpath);
              },
            ),
          ),
          Divider(
            thickness: 5,
          ),
          createDrawerItem(
            icon: Icons.text_fields,
            text: "Glossary Management",
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, RoutePath.managepath);
            },
          ),
          Divider(
            thickness: 5,
          ),
          createDrawerItem(
            icon: Icons.exit_to_app,
            text: "Sign Out",
            onTap: () async{
              await userprovider.logOut();
              Navigator.of(context).pop();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(RoutePath.homepath, (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }
}

Widget _createHeader() {
  MaterialColor colorCustom = MaterialColor(0xFF2b814b, color);
  return Container(
    height: 80,
    child: DrawerHeader(
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: colorCustom,
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 20,
            left: 40,
            child: Text("OCR Glossary Dictionary",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),),
          ),
        ],
      ),
    ),
  );
}

Widget createDrawerItem(
    {IconData icon, String text, GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(text),
        ),
      ],
    ),
    onTap: onTap,
  );
}
