import 'package:flutter/material.dart';
import 'qr_image.dart';
import 'package:flutter/services.dart';

class GenerateQRCode extends StatefulWidget {
  const GenerateQRCode({super.key});

  @override
  GenerateQRCodeState createState() => GenerateQRCodeState();
}

class GenerateQRCodeState extends State<GenerateQRCode> {
  final List<TextEditingController> controllers = [
    TextEditingController(), // Scouter's Name
    TextEditingController(), // Match Number
    TextEditingController(), // Team Number
    TextEditingController(),
    TextEditingController()
  ];
  TextEditingController finalController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: controllers[0],
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Scouter\'s Name'),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: controllers[1],
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3)
              ],
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Match Number'),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: controllers[2],
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(5)
              ],
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Team Number'),
            ),
          ),
          //This button when pressed navigates to QR code generation
          ElevatedButton(
              onPressed: () async {
                finalController.text =
                    '${controllers[0].text}\t${controllers[1].text}\t${controllers[2].text}';
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('data: ${finalController.text}'),
                  ),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) {
                      return QRImage(finalController);
                    }),
                  ),
                );
              },
              child: const Text('GENERATE QR CODE')),
        ],
      ),
    );
  }
}
