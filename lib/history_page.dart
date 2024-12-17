import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';  // Assurez-vous d'importer ce package

class HistoryPage extends StatelessWidget {
  final List<QRHistoryItem> history;
  final Function() onClearHistory;

  const HistoryPage({
    Key? key,
    required this.history,
    required this.onClearHistory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code History'),
        actions: [
          // Bouton pour nettoyer l'historique
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              onClearHistory(); // Appeler la fonction pour vider l'historique
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          final item = history[index];
          return ListTile(
            title: Text(item.data),
            subtitle: Text('Usage count: ${item.usageCount}'),
            onTap: () {
              // Lorsque l'on clique, on affiche l'image du QR code et le nombre d'utilisations
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(item.data),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 200.0,
                          height: 200.0,
                          child: QrImageView(data: item.data, size: 200.0),
                        ),
                        const SizedBox(height: 20),
                        Text('Usage count: ${item.usageCount}'),
                        ElevatedButton(
                          onPressed: () {
                            // Incrémentation du nombre d'utilisations
                            item.usageCount++;
                            Navigator.of(context).pop();
                          },
                          child: const Text('Use QR Code'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Clear le QR code (supprimer de l'historique)
                            Navigator.of(context).pop();
                            onClearItem(item); // Effacer l'élément spécifique
                          },
                          child: const Text('Clear QR Code'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  // Fonction pour effacer un item spécifique
  void onClearItem(QRHistoryItem item) {
    history.remove(item); // Retirer l'élément de l'historique
  }
}

class QRHistoryItem {
  String data;
  int usageCount;

  QRHistoryItem({required this.data, required this.usageCount});
}
