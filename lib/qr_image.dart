import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRImage extends StatelessWidget {
  final TextEditingController finalController;
  final String matchNumber;
  final String teamNumber;

  QRImage(this.finalController, this.matchNumber, this.teamNumber);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Match $matchNumber - Team $teamNumber'),
        centerTitle: true,
      ),
      body: Center(
        child: QrImageView(
          data: finalController.text,
          size: 280,
          // You can include embeddedImageStyle Property if you
          //wanna embed an image from your Asset folder
          embeddedImageStyle: QrEmbeddedImageStyle(
            size: const Size(
              100,
              100,
            ),
          ),
        ),
      ),
    );
  }
}
