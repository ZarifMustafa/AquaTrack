import 'package:flutter/material.dart';
import 'history_details_page.dart';

class HistoryPage extends StatelessWidget {
  final Map<String, dynamic> resident;

  HistoryPage({required this.resident});

  // Mock usage history data for demonstration purposes
  final Map<int, List<Map<String, dynamic>>> usageHistory = {
    2023: [
      {'month': 'July', 'usage': 120, 'bill': 24.00},
      {'month': 'June', 'usage': 150, 'bill': 30.00},
      {'month': 'May', 'usage': 110, 'bill': 22.00},
      {'month': 'April', 'usage': 130, 'bill': 26.00},
      {'month': 'March', 'usage': 140, 'bill': 28.00},
    ],
    2022: [
      {'month': 'December', 'usage': 160, 'bill': 32.00},
      {'month': 'November', 'usage': 170, 'bill': 34.00},
      {'month': 'October', 'usage': 180, 'bill': 36.00},
    ],
  };

  String _getUsageLevel(int usage) {
    if (usage <= 100) return 'Moderate';
    if (usage <= 150) return 'High';
    if (usage <= 200) return 'Alarming';
    return 'Excessive';
  }

  Color _getUsageLevelColor(String usageLevel) {
    switch (usageLevel) {
      case 'Moderate':
        return Colors.green;
      case 'High':
        return Colors.orange;
      case 'Alarming':
        return Colors.red;
      case 'Excessive':
        return Colors.purple;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History of ${resident['residentName']}'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [Colors.blue.shade400, Color.fromARGB(255, 130, 186, 221)],
          ),
        ),
        child: ListView.builder(
          itemCount: usageHistory.keys.length,
          itemBuilder: (context, index) {
            int year = usageHistory.keys.elementAt(index);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$year',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 8.0),
                Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Table(
                          border: TableBorder.all(color: Colors.blueAccent),
                          columnWidths: {
                            0: FlexColumnWidth(2),
                            1: FlexColumnWidth(1),
                            2: FlexColumnWidth(1),
                            3: FlexColumnWidth(1),
                            4: FlexColumnWidth(1),
                          },
                          children: [
                            TableRow(
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                              ),
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Month', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Usage (units)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Usage Level', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Bill (\$)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Details', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                            ...usageHistory[year]!.map((record) {
                              String usageLevel = _getUsageLevel(record['usage']);
                              return TableRow(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(record['month']),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(record['usage'].toString()),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      usageLevel,
                                      style: TextStyle(color: _getUsageLevelColor(usageLevel)),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(record['bill'].toStringAsFixed(2)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => HistoryDetailsPage(
                                              resident: resident,
                                              year: year,
                                              month: record['month'],
                                              usage: record['usage'],
                                              bill: record['bill'],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text('View'),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
