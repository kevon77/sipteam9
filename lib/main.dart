import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:skin_disease_app/screens/home_screen.dart';
import 'package:skin_disease_app/screens/results_screen.dart';
import 'package:skin_disease_app/screens/welcome_screen.dart';
import 'package:skin_disease_app/screens/questionnaire_screen.dart';
import 'package:skin_disease_app/screens/nearby_dermatologists_screen.dart'; // ✅ Add this

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skin Disease Detector',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/home': (context) => HomeScreen(),
        '/questionnaire': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map;
          return QuestionnaireScreen(
  image: args['image'],
  imageResult: args['imageResult'],
);

        },
        '/results': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map;
          return ResultsScreen(
            image: args['image'],
            result: args['imageResult'],
            questionnaire: args['questionnaire'],
          );
        },
        '/dermatologists': (context) => NearbyDermatologistsScreen(), // ✅ Add this
      },
    );
  }
}
