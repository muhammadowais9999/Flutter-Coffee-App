import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Import your firebase_options.dart
import 'splash_screen.dart'; // Import the splash screen (Ensure you have the correct path)

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      debugShowCheckedModeBanner: false, // Disable debug banner
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 139, 69, 19), // Coffee color
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color.fromARGB(255, 210, 180, 140), // Light brown for accent
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.brown), // Text color for large body text
        ),
      ),
      home: SplashScreen(), // Removed 'const' from here
    );
  }
}
