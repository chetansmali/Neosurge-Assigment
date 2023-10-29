import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:neosurge_finance/src/presentation/widgets/app_bar.dart';

class LineChartPage extends StatefulWidget {
  final double totalExpense;
  final double totalIncome;

  const LineChartPage({Key? key, required this.totalExpense, required this.totalIncome,}) : super(key: key);

  @override
  State<LineChartPage> createState() => _LineChartPageState();
}

class _LineChartPageState extends State<LineChartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(name: 'Analytics',),

      body: ListView(
        children: <Widget>[
          Container(
            width: 300, // Set the desired width
            height: 350, // Set the desired height (increased to accommodate the title)
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white, // Background color for the chart container
              borderRadius: BorderRadius.circular(12), // Add rounded corners
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 2), // Add a subtle shadow
                ),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Pie chart', // Add a title for context
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: PieChart(
                    PieChartData(sections: [
                      PieChartSectionData(

                        color: const Color(0xFFD32F2F),
                        value: widget.totalExpense,
                        title: 'Expenses',
                      ),
                      PieChartSectionData(
                        color: const Color(0xFF388E3C),
                        value: widget.totalIncome,
                        title: 'Income',
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
