import 'package:flutter/material.dart';
import 'package:ocrglossary/ui/view/adminFeedbackScreen.dart';
import 'package:ocrglossary/ui/view/adminScreen.dart';
import 'package:ocrglossary/ui/view/adminUserScreen.dart';
import 'package:ocrglossary/ui/view/feedbackScreen.dart';
import 'package:ocrglossary/ui/view/home.dart';
import 'package:ocrglossary/ui/view/loginScreen.dart';
import 'package:ocrglossary/ui/view/registerScreen.dart';
import 'package:ocrglossary/ui/view/adminMainScreen.dart';
import 'package:ocrglossary/ui/view/userMainScreen.dart';
import 'package:ocrglossary/ui/view/userbookmarkScreen.dart';
import 'package:ocrglossary/ui/view/userupdateScreen.dart';

class Router{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case '/':
        return MaterialPageRoute(
            builder: (_) => homeScreen(),
            settings: RouteSettings(name: "Home Screen")
        );
      case '/adminScreen':
        return MaterialPageRoute(builder: (_) => adminScreen(),
            settings: RouteSettings(name: "Admin manage glossary screen"));
      case '/loginScreen':
        return MaterialPageRoute(builder: (_) => LoginScreen(),
            settings: RouteSettings(name: "Login Screen"));
      case '/registerScreen':
        return MaterialPageRoute(builder: (_) => RegisterScreen(),
            settings: RouteSettings(name: "User Registration Screen"));
      case '/adminMainScreen':
        return MaterialPageRoute(builder: (_) => AdminMainScreen(),
            settings: RouteSettings(name: "Admin Main Screen"));
      case '/adminUserScreen':
        return MaterialPageRoute(builder: (_) => AdminUserScreen(),
            settings: RouteSettings(name: "Registered User Screen"));
      case '/adminFeedbackScreen':
        return MaterialPageRoute(builder: (_) => AdminFeedbackScreen(),
            settings: RouteSettings(name: "All User Feedback Screen"));
      case '/userMainScreen':
        return MaterialPageRoute(builder: (_) => UserMainScreen(),
            settings: RouteSettings(name: "userMain Screen"));
      case '/userbookmarkScreen':
        return MaterialPageRoute(builder: (_) => UserBookmarkScreen(),
            settings: RouteSettings(name: "Bookmark Screen"));
      case '/userupdateScreen':
        return MaterialPageRoute(builder: (_) => UserUpdateScreen(),
            settings: RouteSettings(name: "Update Screen"));
      case '/feedbackScreen':
        return MaterialPageRoute(builder: (_) => FeedbackScreen(),
            settings: RouteSettings(name: "FeedbackScreen"));
        default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No Route'),
            ),
          ),
        );
    }
  }
}