import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ocrglossary/core/services/analyticsprocessapi.dart';
import 'package:ocrglossary/core/viewmodel/imageModel.dart';
import 'package:ocrglossary/core/viewmodel/signupmodel.dart';
import 'package:ocrglossary/ui/view/home.dart';
import 'dart:async';
import 'package:ocrglossary/ui/router.dart';
import 'package:ocrglossary/locator.dart';
import 'package:provider/provider.dart';
import 'package:ocrglossary/core/viewmodel/CRUDmodel.dart';
import 'package:ocrglossary/core/viewmodel/feedbackModel.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'core/viewmodel/bookmarkModel.dart';
import 'package:ocrglossary/ui/widgets/FadeAnimation.dart';

void main() {
  setupLocator();
  runApp(MyApp());
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
class MyApp extends StatelessWidget {

  MaterialColor colorCustom = MaterialColor(0xFF2b814b, color);
  @override

  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => locator<CRUDmodel>()),
        ChangeNotifierProvider(builder: (_) => locator<SignUpModel>()),
        ChangeNotifierProvider(builder: (_) => locator<FeedbackModel>()),
        ChangeNotifierProvider(builder: (_) => locator<BookmarkModel>()),
        ChangeNotifierProvider(builder: (_) => locator<ImageModel>()),
      ],
      child:MaterialApp(
        theme: ThemeData(
          primaryColor: colorCustom,
        ),
        navigatorObservers: [locator<AnalyticsProcessApi>().getAnalysticsObserver()],
        onGenerateRoute: Router.generateRoute,
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState();
  MaterialColor colorCustom = MaterialColor(0xFF2b814b, color);
  @override

  void initState(){
    startTimeout();
    super.initState();
  }

  void handleTimeout() {
    Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (BuildContext context) => new homeScreen()));
  }

  startTimeout() async {
    var duration = const Duration(seconds: 6);
    return new Timer(duration, handleTimeout);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
                decoration: BoxDecoration(color: colorCustom)
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FadeAnimation(2.0
                          ,CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 80.0,
                            child: Container(
                              height: 150,
                              width: 120,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/FYP.png"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top:20.0),
                        ),
                        FadeAnimation(2.4
                          , Text(
                            "OCR Glossary Dictionary",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    flex:2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 200,
                          child: SpinKitWave(
                            color: Colors.white,
                            size: 40.0,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top:50.0),
                        ),
                        FadeAnimation(2.0
                          ,Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/logo.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15,),
                        FadeAnimation(2.4
                          ,Text(
                            "AKMAL",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        )
                      ],
                    )
                ),
              ],
            ),
          ],
        ));
  }
}
