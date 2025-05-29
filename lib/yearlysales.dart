import 'package:flutter/material.dart';

class YearlySalesReportPage extends StatefulWidget {
  const YearlySalesReportPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _YearlySalesReportPageState createState() => _YearlySalesReportPageState();
}

class _YearlySalesReportPageState extends State<YearlySalesReportPage> {
  // List of years to be displayed
  final List<String> years = ['2020', '2021', '2022', '2023', '2024', '2025'];
  
  // List of months
  final List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June', 
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  // Sample sales data (you'd typically fetch this from a backend or database)
  final List<Map<String, dynamic>> salesData = [
    {'month': 'January', 'quantity': 875, 'sales': 50893.00},
    {'month': 'February', 'quantity': 920, 'sales': 53240.50},
    {'month': 'March', 'quantity': 790, 'sales': 45670.25},
    {'month': 'April', 'quantity': 1050, 'sales': 61200.75},
    {'month': 'May', 'quantity': 830, 'sales': 48350.60},
    {'month': 'June', 'quantity': 965, 'sales': 56180.90},
    {'month': 'July', 'quantity': 1100, 'sales': 64020.30},
    {'month': 'August', 'quantity': 885, 'sales': 51570.45},
    {'month': 'September', 'quantity': 940, 'sales': 54820.10},
    {'month': 'October', 'quantity': 1020, 'sales': 59460.80},
    {'month': 'November', 'quantity': 780, 'sales': 45360.20},
    {'month': 'December', 'quantity': 1200, 'sales': 69900.50},
  ];
  
  // Currently selected year
  String selectedYear = 'Year';

  void _showYearPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Select Year',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ...years.map((year) => ListTile(
              title: Text(
                year,
                style: TextStyle(
                  color: selectedYear == year ? Colors.pink : Colors.black,
                ),
              ),
              onTap: () {
                setState(() {
                  selectedYear = year;
                });
                Navigator.pop(context);
              },
            )),
          ],
        );
      },
    );
  }

  // Calculate total sales and quantity
  Map<String, num> _calculateTotals() {
    int totalQuantity = salesData.fold(0, (int sum, item) => sum + (item['quantity'] as int));
    double totalSales = salesData.fold(0.0, (double sum, item) => sum + (item['sales'] as double));
    
    return {
      'quantity': totalQuantity,
      'sales': totalSales
    };
  }

  @override
  Widget build(BuildContext context) {
    final totals = _calculateTotals();

    return Scaffold(
      backgroundColor: const Color(0xFFF1EDE8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // Remove default back button
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
        title: const Text(
          'Yearly Sales Report',
          style: TextStyle(
            color: Color(0xFF172B4D),
            fontWeight: FontWeight.bold,
            fontFamily: 'DM Sans'
          ),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              // Year Selector
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.black.withOpacity(0.1)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, color: Colors.black),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () => _showYearPicker(context),
                            child: Text(
                              selectedYear,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              // ListView
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: salesData.length,
                  itemBuilder: (context, index) {
                    final monthData = salesData[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                      height: 70, // Fixed height for consistency
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // Yellow background for Month column
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFFFFD685),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                ),
                              ),
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                monthData['month'],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          // White background for other columns
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Quantity Sold',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Text(
                                          '${monthData['quantity']}',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Total Sales',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Text(
                                          '\$${monthData['sales'].toStringAsFixed(2)}',
                                          style: const TextStyle(
                                            color: Colors.green,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              
              // Total Summary - Modified to match the UI image
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                      '  Total Quantity',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '  Grand Total',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          '         ${totals['quantity']}',
                          style: const TextStyle(
                            color: Colors.orange,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '         \$${totals['sales']!.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}