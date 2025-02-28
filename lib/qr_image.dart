import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'package:scouting/db.dart';

class QRImage extends StatelessWidget {
  final TextEditingController finalController;
  final String matchNumber;
  final String teamNumber;

  const QRImage(this.finalController, this.matchNumber, this.teamNumber,
      {super.key});

  Future<void> _saveQRCode(Uint8List qrCodeBytes) async {
    await insertQRCode(qrCodeBytes, matchNumber, teamNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Match $matchNumber - Team $teamNumber'),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<Uint8List>(
          future: _generateQRCode(finalController.text),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.memory(snapshot.data!),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => _saveQRCode(snapshot.data!),
                      child: const Text('Save QR Code to Database'),
                    ),
                  ],
                );
              } else {
                return const Text('Error generating QR code');
              }
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Future<Uint8List> _generateQRCode(String data) async {
    final qrValidationResult = QrValidator.validate(
      data: data,
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.L,
    );

    if (qrValidationResult.status == QrValidationStatus.valid) {
      final qrCode = qrValidationResult.qrCode!;
      final painter = QrPainter.withQr(
        qr: qrCode,
        eyeStyle: const QrEyeStyle(
          eyeShape: QrEyeShape.square,
          color: Color(0xFF000000),
        ),
        dataModuleStyle: const QrDataModuleStyle(
          dataModuleShape: QrDataModuleShape.square,
          color: Color(0xFF000000),
        ),
        gapless: true,
      );

      final picData = await painter.toImageData(280);
      return picData!.buffer.asUint8List();
    } else {
      throw Exception('QR code generation failed');
    }
  }
}
