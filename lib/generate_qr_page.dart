// TODO: make QR Code search page

import 'package:flutter/material.dart';
import 'qr_image.dart';
import 'qr_code_search.dart';
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
    TextEditingController(), // 18 - Comments
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

  Widget buildTextFieldContainer(int index, String labelText,
      {TextInputType keyboardType = TextInputType.text,
      List<TextInputFormatter>? inputFormatters}) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: TextField(
        controller: controllers[index],
        cursorColor: Colors.black,
        style: const TextStyle(color: Colors.black),
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: labelText,
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Container(
      margin: const EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 25,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Expanded(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildTextFieldContainer(0, 'Scouter\'s Name'),
              buildTextFieldContainer(1, 'Match Number',
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(3)
                  ]),
              buildTextFieldContainer(2, 'Team Number',
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(5)
                  ]),
              buildSectionTitle('Auton:'),
              buildTextFieldContainer(3, 'Leave Starting Line (yes/no)',
                  inputFormatters: [LengthLimitingTextInputFormatter(3)]),
              buildTextFieldContainer(4, 'Coral L1',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
              buildTextFieldContainer(5, 'Coral L2',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
              buildTextFieldContainer(6, 'Coral L3',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
              buildTextFieldContainer(7, 'Coral L4',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
              buildTextFieldContainer(8, 'Processor Score',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
              buildTextFieldContainer(9, 'Net Score',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
              buildSectionTitle('Teleop:'),
              buildTextFieldContainer(10, 'Coral L1',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
              buildTextFieldContainer(11, 'Coral L2',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
              buildTextFieldContainer(12, 'Coral L3',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
              buildTextFieldContainer(13, 'Coral L4',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
              buildTextFieldContainer(14, 'Processor Score',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
              buildTextFieldContainer(15, 'Net Score',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
              Container(
                  // Pickup From Dropdown
                  margin: const EdgeInsets.all(25),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      const Text(
                        'Pickup From:',
                        style: TextStyle(color: Colors.black),
                      ),
                      const SizedBox(width: 10),
                      DropdownButton(
                        value: pickupFromValue,
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.black),
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
                        items: pickupFrom
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  )),
              buildTextFieldContainer(
                  16, 'Scored in Opponent Processor (yes/no)',
                  inputFormatters: [LengthLimitingTextInputFormatter(3)]),
              buildSectionTitle('Endgame:'),
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
                            border: OutlineInputBorder(),
                            labelText: 'Barge Time'),
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
                  // Robot Status Dropdown
                  margin: const EdgeInsets.all(25),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      const Text(
                        'Final Robot Status:',
                        style: TextStyle(color: Colors.black),
                      ),
                      const SizedBox(width: 10),
                      DropdownButton(
                        value: robotStatusValue,
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.black),
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
                      ),
                    ],
                  )),
              Container(
                // Comments
                margin: const EdgeInsets.all(20),
                alignment: Alignment.centerLeft,
                child: TextField(
                  controller: controllers[18],
                  cursorColor: Colors.black,
                  style: const TextStyle(color: Colors.black),
                  maxLines: 3,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Comments'),
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Color.fromARGB(255, 255, 183, 75),
                    padding: const EdgeInsets.all(20),
                  ),
                  onPressed: () async {
                    finalController.text =
                        '${controllers[0].text}\t${controllers[1].text}\t${controllers[2].text}\t${controllers[3].text}\t${controllers[4].text}\t${controllers[5].text}\t${controllers[6].text}\t${controllers[7].text}\t${controllers[8].text}\t${controllers[9].text}\t${controllers[10].text}\t${controllers[11].text}\t${controllers[12].text}\t${controllers[13].text}\t${controllers[14].text}\t${controllers[15].text}\t$pickupFromValue\t${controllers[16].text}\t${controllers[17].text}\t$robotStatusValue\t${controllers[18].text}';

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) {
                          return QRImage(finalController, controllers[1].text,
                              controllers[2].text);
                        }),
                      ),
                    );
                  },
                  child: const Text('GENERATE QR CODE')),
              const SizedBox(height: 5),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Color.fromARGB(255, 255, 183, 75),
                  padding: const EdgeInsets.all(20),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QRCodeSearch(),
                    ),
                  );
                },
                child: const Text('SEARCH QR CODES'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
