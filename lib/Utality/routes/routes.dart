import 'package:adil_fyp/Utality/routes/route_name.dart';
import 'package:adil_fyp/view/auth/login_screen.dart';
import 'package:adil_fyp/view/auth/signup_screen.dart';
import 'package:adil_fyp/view/document_Viewa/docview.dart';
import 'package:adil_fyp/view/exam_screen.dart';
import 'package:adil_fyp/view/initialtest/academic_test.dart';
import 'package:adil_fyp/view/initialtest/additional_academic_test.dart';
import 'package:adil_fyp/view/initialtest/anf_intelligence_test.dart';
import 'package:adil_fyp/view/initialtest/iitial_test.dart';
import 'package:adil_fyp/view/initialtest/mock_test.dart';
import 'package:adil_fyp/view/initialtest/tests_screen.dart';
import 'package:adil_fyp/view/initialtest/verbal_test.dart';
import 'package:adil_fyp/view/mcq/score_screen.dart';
import 'package:adil_fyp/view/mcq/testing_screen.dart';
import 'package:adil_fyp/view/mcq/training_screen.dart';
import 'package:adil_fyp/view/menu_screen.dart';
import 'package:adil_fyp/view/profile_screen.dart';
import 'package:adil_fyp/view/splash_screen.dart';
import 'package:adil_fyp/view/subjects_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.home:
        return MaterialPageRoute(
          builder: (context) => MenuScreen(),
        );
      case RouteNames.login:
        return MaterialPageRoute(
          builder: (context) => LoginScreen(),
        );
      case RouteNames.signup:
        return MaterialPageRoute(
          builder: (context) => SignUpScreen(),
        );
      case RouteNames.splashscreen:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
        );
      case RouteNames.examscreen:
        return MaterialPageRoute(
          builder: (context) => ExamsScreen(),
        );
      case RouteNames.subjectscreen:
        return MaterialPageRoute(
          builder: (context) => SubjectsScreen(),
        );
      case RouteNames.viewerscreen:
        return MaterialPageRoute(
          builder: (context) => DocumentViewer(
            data: settings.arguments as Map,
          ),
        );
      case RouteNames.initialscreen:
        return MaterialPageRoute(
          builder: (context) => InitialTest(
            data: settings.arguments as String,
          ),
        );
      case RouteNames.tests_screen:
        return MaterialPageRoute(
          builder: (context) => TestsScreen(),
        );
      case RouteNames.verbal_test:
        return MaterialPageRoute(
          builder: (context) => VerbalTest(),
        );
      case RouteNames.academic_test:
        return MaterialPageRoute(
          builder: (context) => AcademicTest(),
        );
      case RouteNames.mcq_train:
        return MaterialPageRoute(
          builder: (context) =>
              McqScreen(coladdress: settings.arguments as String),
        );
      case RouteNames.additional_academic:
        return MaterialPageRoute(
          builder: (context) => AdditionalAcademic(
            data: settings.arguments as Map,
          ),
        );
      case RouteNames.profile_screen:
        return MaterialPageRoute(
          builder: (context) => ProfileScreen(
            data: settings.arguments as dynamic,
          ),
        );
      case RouteNames.mocktest_screen:
        return MaterialPageRoute(builder: (context) => MockTest());
      case RouteNames.mcq_test_screen:
        return MaterialPageRoute(
          builder: (context) =>
              McqTestScreen(coladdress: settings.arguments as String),
        );
      case RouteNames.score_screen:
        return MaterialPageRoute(
          builder: (context) =>
              ScoreScreen(score: settings.arguments as String),
        );
      case RouteNames.anf_intelligence_test:
        return MaterialPageRoute(
          builder: (context) => AnfIntelligenceTest(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold();
          },
        );
    }
  }
}
