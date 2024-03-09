import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orgami/firebase_options.dart';
import 'package:orgami/view/splash_screeen.dart';
import 'package:orgami/viewmodel/controller.dart';
import 'package:orgami/viewmodel/firestore.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Controller>(
          create: (context) => Controller(),
        ),
          ChangeNotifierProvider<FirestoreDb>(
          create: (context) => FirestoreDb(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        // title: 'Flutter Demo',
        // theme: ThemeData(
        //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //   useMaterial3: true,
        // ),
        home: SplashScreen(),
      ),
    );
  }
}
