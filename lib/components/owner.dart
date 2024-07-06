import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class OwnerPage extends StatelessWidget {
  final String ownerName;
  final double todayUsage;
  final double monthUsage;

  OwnerPage({required this.ownerName, required this.todayUsage, required this.monthUsage});

  final List<double> dailyUsage = [
    2.5, 3.0, 1.8, 2.2, 2.0, 2.6, 3.1, 2.9, 2.3, 2.7,
    2.4, 3.0, 2.8, 2.5, 3.2, 2.1, 2.4, 2.7, 3.0, 2.5,
    2.9, 2.6, 2.3, 3.1, 2.8, 2.5, 2.7, 2.6, 3.0, 2.9
  ];
  final List<double> monthlyUsage = [60, 62, 58, 65, 64, 63, 67, 61, 66, 64, 62, 68];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Owner Dashboard'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [Colors.blue.shade400, Color.fromARGB(255, 130, 186, 221)],
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Owner: $ownerName',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                "Today's Usage: $todayUsage Liters",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "This Month's Usage: $monthUsage Liters",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 32),
              Text(
                'Daily Usage (Current Month) - Line Chart',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Container(
                height: 300,
                color: Colors.white,
                child: DailyUsageLineChart(dailyUsage: dailyUsage),
              ),
              SizedBox(height: 32),
              Text(
                'Monthly Usage',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Container(
                height: 300,
                color: Colors.white,
                child: MonthlyUsageChart(monthlyUsage: monthlyUsage),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  // Navigate to history page
                },
                child: Text('History'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Navigate to pay bill page
                },
                child: Text('Pay Bill'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DailyUsageLineChart extends StatelessWidget {
  final List<double> dailyUsage;

  DailyUsageLineChart({required this.dailyUsage});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: true),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.blue, width: 1),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: dailyUsage.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value)).toList(),
            isCurved: true,
            color: Colors.blue,
            barWidth: 3,
            dotData: FlDotData(show: false),
          ),
        ],
        lineTouchData: LineTouchData(enabled: true),
        minY: 0,
        maxY: 5,
        extraLinesData: ExtraLinesData(horizontalLines: [
          HorizontalLine(
            y: 2,
            color: Colors.green,
            strokeWidth: 1,
            dashArray: [5, 5],
            label: HorizontalLineLabel(
              show: true,
              labelResolver: (line) => 'Moderate',
              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
          ),
          HorizontalLine(
            y: 3,
            color: Colors.orange,
            strokeWidth: 1,
            dashArray: [5, 5],
            label: HorizontalLineLabel(
              show: true,
              labelResolver: (line) => 'High',
              style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
            ),
          ),
          HorizontalLine(
            y: 4,
            color: Colors.red,
            strokeWidth: 1,
            dashArray: [5, 5],
            label: HorizontalLineLabel(
              show: true,
              labelResolver: (line) => 'Alarming',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
          HorizontalLine(
            y: 5,
            color: Colors.purple,
            strokeWidth: 1,
            dashArray: [5, 5],
            label: HorizontalLineLabel(
              show: true,
              labelResolver: (line) => 'Excess',
              style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
            ),
          ),
        ]),
      ),
    );
  }
}

class MonthlyUsageChart extends StatelessWidget {
  final List<double> monthlyUsage;

  MonthlyUsageChart({required this.monthlyUsage});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: true),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.blue, width: 1),
        ),
        barGroups: monthlyUsage.asMap().entries.map((e) {
          return BarChartGroupData(
            x: e.key,
            barRods: [
              BarChartRodData(
                toY: e.value,
                color: e.value > 65
                    ? Colors.red
                    : e.value > 60
                        ? Colors.orange
                        : Colors.green,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
