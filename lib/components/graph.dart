import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(Graph());
}

class Graph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Water Consumption Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WaterConsumptionPage(),
    );
  }
}

class WaterConsumptionPage extends StatelessWidget {
  // Assume these variables are given
  final List<double> dailyUsage = [
    2.5,
    3.0,
    1.8,
    2.2,
    2.0,
    2.6,
    3.1,
    2.9,
    2.3,
    2.7,
    2.4,
    3.0,
    2.8,
    2.5,
    3.2,
    2.1,
    2.4,
    2.7,
    3.0,
    2.5,
    2.9,
    2.6,
    2.3,
    3.1,
    2.8,
    2.5,
    2.7,
    2.6,
    3.0,
    2.9
  ];
  final List<double> monthlyUsage = [
    60,
    62,
    58,
    65,
    64,
    63,
    67,
    61,
    66,
    64,
    62,
    68
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Water Consumption Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Daily Usage (Current Month) - Line Chart',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Container(
                height: 300,
                child: DailyUsageLineChart(dailyUsage: dailyUsage),
              ),
              SizedBox(height: 32),
              Text(
                'Daily Usage (Current Month) - Bar Chart',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Container(
                height: 300,
                child: DailyUsageBarChart(dailyUsage: dailyUsage),
              ),
              SizedBox(height: 32),
              Text(
                'Monthly Usage',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Container(
                height: 300,
                child: MonthlyUsageChart(monthlyUsage: monthlyUsage),
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
            show: true, border: Border.all(color: Colors.blue, width: 1)),
        lineBarsData: [
          LineChartBarData(
            spots: dailyUsage
                .asMap()
                .entries
                .map((e) => FlSpot(e.key.toDouble(), e.value))
                .toList(),
            isCurved: true,
            color: Colors.blue,
            barWidth: 3,
            dotData: FlDotData(show: false),
          ),
        ],
      ),
    );
  }
}

class DailyUsageBarChart extends StatelessWidget {
  final List<double> dailyUsage;

  DailyUsageBarChart({required this.dailyUsage});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: true),
        borderData: FlBorderData(
            show: true, border: Border.all(color: Colors.blue, width: 1)),
        barGroups: dailyUsage.asMap().entries.map((e) {
          return BarChartGroupData(
              x: e.key,
              barRods: [BarChartRodData(toY: e.value, color: Colors.blue)]);
        }).toList(),
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
            show: true, border: Border.all(color: Colors.blue, width: 1)),
        barGroups: monthlyUsage.asMap().entries.map((e) {
          return BarChartGroupData(
              x: e.key,
              barRods: [BarChartRodData(toY: e.value, color: Colors.blue)]);
        }).toList(),
      ),
    );
  }
}
