import 'package:flutter/material.dart';
import 'package:qr_scanner_app/generate_page.dart';
import 'package:qr_scanner_app/history_page.dart';
import 'package:qr_scanner_app/theme_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<QRHistoryItem> _history = [];

  final List<Widget> _pages = [];

  // Ajout de la fonction pour ajouter un QR à l'historique
  void _addToHistory(String qrData) {
    setState(() {
      _history.add(QRHistoryItem(data: qrData, usageCount: 0)); // Ajout du QR code à l'historique
    });
  }

  // Fonction pour vider l'historique
  void _clearHistory() {
    setState(() {
      _history.clear(); // Vider l'historique
    });
  }

  @override
  void initState() {
    super.initState();

    _pages.addAll([
      GeneratePage(addToHistory: _addToHistory), // Passer la fonction d'ajout à GeneratePage
      HistoryPage(
        history: _history, // Passer l'historique à HistoryPage
        onClearHistory: _clearHistory, // Passer la fonction de nettoyage
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = ThemeProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Scanner App'),
        actions: [
          IconButton(
            icon: Icon(themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'Generate QR',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
      ),
    );
  }
}
