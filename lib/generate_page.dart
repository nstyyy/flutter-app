import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GeneratePage extends StatefulWidget {
  final Function(String) addToHistory;

  const GeneratePage({Key? key, required this.addToHistory}) : super(key: key);

  @override
  _GeneratePageState createState() => _GeneratePageState();
}

class _GeneratePageState extends State<GeneratePage> {
  final TextEditingController _controller = TextEditingController();
  String? _qrData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Enter URL or Text',
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _qrData = _controller.text; // Enregistrer le texte entré
              });
            },
            child: const Text('Generate QR'),
          ),
          const SizedBox(height: 20),
          if (_qrData != null) ...[
            QrImageView(
              data: _qrData!,
              size: 200.0,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_qrData != null && _qrData!.isNotEmpty) {
                  widget.addToHistory(_qrData!); // Sauvegarder dans l'historique
                  print("QR Code ajouté à l'historique: $_qrData");
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('QR Code saved to history!')),
                  );
                }
              },
              child: const Text('Save to History'),
            ),
          ],
        ],
      ),
    );
  }
}
