import 'package:flutter/material.dart';
import 'home_page.dart';
import 'theme_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(  // Assurez-vous que ThemeProvider entoure votre application
      child: Builder(
        builder: (context) {
          final themeProvider = ThemeProvider.of(context);
          return MaterialApp(
            title: 'QR Scanner App',
            theme: ThemeData(
              brightness: Brightness.light,  // Applique le thème clair (fond blanc)
              primaryColor: Colors.blue,
              appBarTheme: const AppBarTheme(
                color: Colors.blue,  // Couleur de l'AppBar
              ),
              scaffoldBackgroundColor: Colors.white,  // Fond blanc pour toute la page
            ),
            darkTheme: ThemeData.dark(),  // Thème sombre si activé
            themeMode: themeProvider.themeMode,  // Utilise le thème du ThemeProvider
            home: const HomePage(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
