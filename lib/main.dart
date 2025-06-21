import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:strawberry_disease_detection/firebase_options.dart';
import 'package:strawberry_disease_detection/provider/environment_conditions_provider.dart';
import 'package:strawberry_disease_detection/view/disease_details_page.dart';
import 'package:strawberry_disease_detection/view/home_page.dart';
import 'package:strawberry_disease_detection/view/login_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:strawberry_disease_detection/provider/authentication_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  await Hive.openBox('myBox');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAuth.instance.signOut();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProxyProvider<AuthenticationProvider, EnvironmentConditionsProvider>(
          create: (_) => EnvironmentConditionsProvider(userId: ''),
          update: (_, authProvider, _) => EnvironmentConditionsProvider(userId: authProvider.userId),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            centerTitle: true,
          )
        ),
        initialRoute: user != null ? "/" : "/login",
        routes: {
          "/": (context) => HomePage(),
          "/login": (context) => LoginPage(),
          "/disease_details": (context) => DiseaseDetailsPage()
        },
      ),
    );
  }
}
