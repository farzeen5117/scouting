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
    TextEditingController(), // 0 - Scouter's Name
    TextEditingController(), // 1 - Match Number
    TextEditingController(), // 2 - Team Number
    TextEditingController(), // 3 - Leave Starting Line
    TextEditingController(), // 4 - Auton Coral L1
    TextEditingController(), // 5 - Auton Coral L2
    TextEditingController(), // 6 - Auton Coral L3
    TextEditingController(), // 7 - Auton Coral L4
    TextEditingController(), // 8 - Auton Processor Score
    TextEditingController(), // 9 - Auton Net Score
    TextEditingController(), // 10 - Teleop Coral L1
    TextEditingController(), // 11 - Teleop Coral L2
    TextEditingController(), // 12 - Teleop Coral L3
    TextEditingController(), // 13 - Teleop Coral L4
    TextEditingController(), // 14 - Teleop Processor Score
    TextEditingController(), // 15 - Teleop Net Score
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
              cursorColor: Colors.black,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Scouter\'s Name'),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: controllers[1],
              cursorColor: Colors.black,
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
              cursorColor: Colors.black,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(5)
              ],
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Team Number'),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            child: Text(
              'Auton:',
              style: const TextStyle(
                fontSize: 25,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: controllers[3],
              cursorColor: Colors.black,
              inputFormatters: [LengthLimitingTextInputFormatter(3)],
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Leave Starting Line (yes/no)'),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: controllers[4],
              cursorColor: Colors.black,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Coral L1'),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: controllers[5],
              cursorColor: Colors.black,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Coral L2'),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: controllers[6],
              cursorColor: Colors.black,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Coral L3'),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: controllers[7],
              cursorColor: Colors.black,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Coral L4'),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: controllers[8],
              cursorColor: Colors.black,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Processor Score'),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: controllers[9],
              cursorColor: Colors.black,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Net Score'),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            child: Text(
              'Teleop:',
              style: const TextStyle(
                fontSize: 25,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: controllers[10],
              cursorColor: Colors.black,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Coral L1'),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: controllers[11],
              cursorColor: Colors.black,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Coral L2'),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: controllers[12],
              cursorColor: Colors.black,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Coral L3'),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: controllers[13],
              cursorColor: Colors.black,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Coral L4'),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: controllers[14],
              cursorColor: Colors.black,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Processor Score'),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: controllers[15],
              cursorColor: Colors.black,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Net Score'),
            ),
          ),
          //This button when pressed navigates to QR code generation
          ElevatedButton(
              onPressed: () async {
                finalController.text =
                    '${controllers[0].text}\t${controllers[1].text}\t${controllers[2].text}\t${controllers[3].text}';
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
