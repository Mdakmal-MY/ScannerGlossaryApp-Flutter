import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ocrglossary/ui/routepath.dart';
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
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          SizedBox(height: 30),
          Text(
            "Welcome",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          SizedBox(height: 10),
          createDrawerItem(
            icon: Icons.supervised_user_circle,
            text: "Login/SignUp",
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, RoutePath.loginpath);
            },
          ),
          createDrawerItem(
            icon: Icons.label,
            text: "Bookmark",
            onTap: () {
              Navigator.of(context).pop();
              showDialog(
                  context: context,
                  builder: (BuildContext context){
                    return AlertDialog(
                      title: Text("Login Required"),
                      content: Text("Please proceed to login to bookmark"),
                    );
                  }
              );
            },
          ),
          Divider(
            thickness: 5,
          ),
          createDrawerItem(
            icon: Icons.assignment_late,
            text: "Feedback",
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, RoutePath.feedbackpath);
            },
          ),
//          createDrawerItem(
//            icon: Icons.thumb_up,
//            text: "Rate Us",
//            onTap: () {
//              Navigator.of(context).pop();
//              Navigator.pushNamed(context, RoutePath.loginpath);
//            },
//          ),
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
