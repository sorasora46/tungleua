import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tungleua/app.dart';
import 'package:tungleua/firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tungleua/provider/theme_provider.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(
      name: "Tungleua", options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: '.env');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      title: 'Tung Leua',
      home: const App(),
    );
        },
    );
  }


