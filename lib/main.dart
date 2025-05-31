import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:strawberry_disease_detection/firebase_options.dart';
import 'package:strawberry_disease_detection/view/login_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  await Hive.openBox('myBox');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Strawberry Disease Detection',
      initialRoute: "/login",
      routes: {
        //"/": (context) => const LandingPage(),
        "/login": (context) => const LoginPage(),

      },
    );
  }
}
