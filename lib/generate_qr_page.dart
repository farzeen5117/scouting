import 'package:flutter/material.dart';
import 'qr_image.dart';
import 'package:flutter/services.dart';
import 'dart:async';

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
    TextEditingController(), // 16 - Scored in Opponent Processor
    TextEditingController(), // 17 - Barge Time
  ];
  TextEditingController finalController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String pickupFromValue = 'Not Attempted';
  String robotStatusValue = 'Not Attempted';
  var pickupFrom = ['Not Attempted', 'Coral Station', 'Floor', 'Both'];
  var finalRobotStatus = [
    'Not Attempted',
    'Parked',
    'Shallow Cage',
    'Deep Cage'
  ];

  Timer? _timer;
  int _start = 0;

  void _startStopwatch() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _start++;
        controllers[17].text = _formatTime(_start);
      });
    });
  }

  void _stopStopwatch() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  void _resetStopwatch() {
    _timer?.cancel();
    setState(() {
      _start = 0;
      controllers[17].text = _formatTime(_start);
    });
  }

  String _formatTime(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // Scouter's Name
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: controllers[0],
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Scouter\'s Name'),
            ),
          ),
          Container(
            // Match Number
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: controllers[1],
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black),
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
            // Team Number
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: controllers[2],
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black),
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
            // Auton Section
            margin: const EdgeInsets.all(20),
            alignment: Alignment.center,
            child: Text(
              'Auton:',
              style: const TextStyle(
                fontSize: 25,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            // Leave Starting Line
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: controllers[3],
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black),
              inputFormatters: [LengthLimitingTextInputFormatter(3)],
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Leave Starting Line (yes/no)'),
            ),
          ),
          Container(
            // Auton Coral L1
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: controllers[4],
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Coral L1'),
            ),
          ),
          Container(
            // Auton Coral L2
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: controllers[5],
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Coral L2'),
            ),
          ),
          Container(
            // Auton Coral L3
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: controllers[6],
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Coral L3'),
            ),
          ),
          Container(
            // Auton Coral L4
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: controllers[7],
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Coral L4'),
            ),
          ),
          Container(
            // Auton Processor Score
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: controllers[8],
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Processor Score'),
            ),
          ),
          Container(
            // Auton Net Score
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: controllers[9],
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Net Score'),
            ),
          ),
          Container(
            // Teleop Section
            margin: const EdgeInsets.all(20),
            alignment: Alignment.center,
            child: Text(
              'Teleop:',
              style: const TextStyle(
                fontSize: 25,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            // Teleop Coral L1
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: controllers[10],
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Coral L1'),
            ),
          ),
          Container(
            // Teleop Coral L2
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: controllers[11],
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Coral L2'),
            ),
          ),
          Container(
            // Teleop Coral L3
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: controllers[12],
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Coral L3'),
            ),
          ),
          Container(
            // Teleop Coral L4
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: controllers[13],
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Coral L4'),
            ),
          ),
          Container(
            // Teleop Processor Score
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: controllers[14],
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Processor Score'),
            ),
          ),
          Container(
            // Teleop Net Score
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: controllers[15],
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Net Score'),
            ),
          ),
          Container(
              // TODO: add label next to dropdown
              // Pickup From Dropdown
              margin: const EdgeInsets.all(25),
              alignment: Alignment.centerLeft,
              child: DropdownButton(
                value: pickupFromValue,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                dropdownColor: Colors.white,
                underline: Container(
                  height: 2,
                  color: Colors.black,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    pickupFromValue = newValue!;
                  });
                },
                items: pickupFrom.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )),
          Container(
            // Scored in Opponent Processor
            margin: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            child: TextField(
              controller: controllers[16],
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black),
              inputFormatters: [LengthLimitingTextInputFormatter(3)],
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Scored in Opponent Processor (yes/no)'),
            ),
          ),
          Container(
            // Endgame Section
            margin: const EdgeInsets.all(20),
            alignment: Alignment.center,
            child: Text(
              'Endgame:',
              style: const TextStyle(
                fontSize: 25,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            // Barge Time Stopwatch
            margin: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controllers[17],
                    cursorColor: Colors.black,
                    style: const TextStyle(color: Colors.black),
                    readOnly: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Barge Time'),
                  ),
                ),
                IconButton(
                    icon: const Icon(Icons.play_arrow, color: Colors.black),
                    onPressed: () {
                      _startStopwatch();
                    }),
                IconButton(
                    icon: const Icon(Icons.stop, color: Colors.black),
                    onPressed: () {
                      _stopStopwatch();
                    }),
                IconButton(
                    icon: const Icon(Icons.replay, color: Colors.black),
                    onPressed: () {
                      _resetStopwatch();
                    }),
              ],
            ),
          ),
          Container(
              // TODO: add label to dropdown
              // Robot Status Dropdown
              margin: const EdgeInsets.all(25),
              alignment: Alignment.centerLeft,
              child: DropdownButton(
                value: robotStatusValue,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                dropdownColor: Colors.white,
                underline: Container(
                  height: 2,
                  color: Colors.black,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    robotStatusValue = newValue!;
                  });
                },
                items: finalRobotStatus
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )),
          //This button when pressed navigates to QR code generation
          ElevatedButton(
              // TODO: change button color
              onPressed: () async {
                finalController
                        .text = // TODO: add everything else to finalController
                    '${controllers[0].text}\t${controllers[1].text}\t${controllers[2].text}\t${controllers[3].text}\t${controllers[4].text}\t${controllers[5].text}\t${controllers[6].text}\t${controllers[7].text}\t${controllers[8].text}\t${controllers[9].text}\t${controllers[10].text}\t${controllers[11].text}\t${controllers[12].text}\t${controllers[13].text}\t${controllers[14].text}\t${controllers[15].text}';
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
