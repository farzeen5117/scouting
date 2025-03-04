import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'db.dart';

class QRCodeSearch extends StatefulWidget {
  const QRCodeSearch({super.key});

  @override
  QRCodeSearchState createState() => QRCodeSearchState();
}

class QRCodeSearchState extends State<QRCodeSearch> {
  final TextEditingController _searchController = TextEditingController();
  String _searchType = 'Match Number';
  List<Map<String, dynamic>> _searchResults = [];

  Future<void> _search() async {
    // List<Map<String, dynamic>> allQRCodes = await retrieveQRCodes();
    // List<Map<String, dynamic>> results;
    if (_searchType == 'Match Number') {
      retrieveQRCodes();
      /* results = allQRCodes
          .where((qrCode) => qrCode['matchNumber'] == _searchController.text)
          .toList(); */
    } else {
      results = allQRCodes
          .where((qrCode) => qrCode['teamNumber'] == _searchController.text)
          .toList();
    }
    setState(() {
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    cursorColor: Colors.black,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: 'Search by $_searchType',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: _searchType,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                  style: const TextStyle(color: Colors.black),
                  dropdownColor: Colors.white,
                  underline: Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _searchType = newValue!;
                    });
                  },
                  items: <String>['Match Number', 'Team Number']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Color.fromARGB(255, 255, 183, 75),
                      padding: const EdgeInsets.all(20)),
                  onPressed: _search,
                  child: const Text('Search'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                      'Match: ${_searchResults[index]['matchNumber']} - Team: ${_searchResults[index]['teamNumber']}',
                    ),
                    subtitle: _searchResults[index]['qrCode'] != null
                        ? Image.memory(
                            _searchResults[index]['qrCode'],
                            height: 100,
                            width: 100,
                          )
                        : const Text('No QR Code available'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
