import 'package:flutter/material.dart';

class HistoryDetailsPage extends StatelessWidget {
  final Map<String, dynamic> resident;
  final int year;
  final String month;
  final int usage;
  final double bill;

  HistoryDetailsPage({
    required this.resident,
    required this.year,
    required this.month,
    required this.usage,
    required this.bill,
  });

  // Mock daily usage data for demonstration purposes
  final List<Map<String, dynamic>> dailyUsage = [
    {'day': 1, 'usage': 5},
    {'day': 2, 'usage': 4},
    {'day': 3, 'usage': 6},
    {'day': 4, 'usage': 5},
    {'day': 5, 'usage': 7},
    {'day': 6, 'usage': 5},
    {'day': 7, 'usage': 8},
    // Add more data as needed
  ];

  String getUsageLevel(int usage) {
    if (usage <= 4) {
      return 'Moderate';
    } else if (usage <= 6) {
      return 'High';
    } else if (usage <= 8) {
      return 'Alarming';
    } else {
      return 'Excessive';
    }
  }

  Color getUsageLevelColor(String level) {
    switch (level) {
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
    String overallUsageLevel = getUsageLevel(usage);
    Color overallUsageLevelColor = getUsageLevelColor(overallUsageLevel);

    return Scaffold(
      appBar: AppBar(
        title: Text('Details for $month, $year'),
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Details for ${resident['residentName']}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 16.0),
              Card(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Year: $year', style: TextStyle(fontSize: 18)),
                      SizedBox(height: 8.0),
                      Text('Month: $month', style: TextStyle(fontSize: 18)),
                      SizedBox(height: 8.0),
                      Text('Usage: $usage units', style: TextStyle(fontSize: 18)),
                      SizedBox(height: 8.0),
                      Text('Bill: \$${bill.toStringAsFixed(2)}', style: TextStyle(fontSize: 18)),
                      SizedBox(height: 8.0),
                      Text(
                        'Usage Level: $overallUsageLevel',
                        style: TextStyle(fontSize: 18, color: overallUsageLevelColor),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Daily Usage',
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
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(1),
                          2: FlexColumnWidth(1),
                        },
                        children: [
                          TableRow(
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                            ),
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Day', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Usage (units)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Usage Level', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          ...dailyUsage.map((record) {
                            String level = getUsageLevel(record['usage']);
                            return TableRow(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(record['day'].toString()),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(record['usage'].toString()),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    level,
                                    style: TextStyle(color: getUsageLevelColor(level)),
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
          ),
        ),
      ),
    );
  }
}
