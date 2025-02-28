import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SalesReport extends StatefulWidget {
  final String filterType;
  final VoidCallback onClose;

  const SalesReport({
    super.key,
    required this.filterType,
    required this.onClose,
  });

  @override
  State<SalesReport> createState() => _SalesReportState();
}

class _SalesReportState extends State<SalesReport> {
  DateTime? startDate;
  DateTime? endDate;
  final DateFormat dateFormat = DateFormat('MM/dd/yyyy');

  @override
  void initState() {
    super.initState();
    startDate = DateTime(2020, 1, 1);
    endDate = DateTime(2026, 12, 31);
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? startDate ?? DateTime.now() : endDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2026),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.orange, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.orange, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size information
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isTablet = screenWidth > 600;
    final bool isLargeTablet = screenWidth > 900;
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: isTablet ? IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.grey),
          onPressed: widget.onClose,
        ) : null,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.description, color: Color(0xFF172B4D)),
            const SizedBox(width: 8),
            Text(
              '${widget.filterType} Sales Report',
              style: const TextStyle(
                color: Color(0xFF172B4D),
                fontWeight: FontWeight.w600,
                fontFamily: "DM Sans"
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.grey),
            onPressed: widget.onClose,
          ),
        ],
      ),
      // Use the full screen width and height for the body
      body: _buildResponsiveLayout(screenWidth, screenHeight, isTablet, isLargeTablet),
    );
  }

  Widget _buildResponsiveLayout(double screenWidth, double screenHeight, bool isTablet, bool isLargeTablet) {
    // Use the full width of the screen
    return SizedBox(
      width: screenWidth,
      height: screenHeight - kToolbarHeight, // Account for AppBar height
      child: Column(
        children: [
          // Date Picker Section
          Container(
            width: screenWidth,
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: _buildDatePicker(true)),
                    const SizedBox(width: 16),
                    Expanded(child: _buildDatePicker(false)),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Sales List - This will take the remaining screen space
          Expanded(
            child: Container(
              width: screenWidth,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: _salesData.length,
                itemBuilder: (context, index) => _buildSalesItem(_salesData[index], screenWidth),
              ),
            ),
          ),
          
          // Total Section
          Container(
            width: screenWidth,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildTotalItem('Total Items', '137', Colors.orange),
                    _buildTotalItem('Total Sales', '\$22,479', const Color(0xFF00A81C)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePicker(bool isStartDate) {
    return InkWell(
      onTap: () => _selectDate(context, isStartDate),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.black),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.black),
                const SizedBox(width: 8),
                Text(
                  dateFormat.format(isStartDate ? startDate! : endDate!),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSalesItem(Map<String, String> data, double screenWidth) {
    // Responsive column widths based on screen size
    final bool isTablet = screenWidth > 600;
    
    // Adjust date container width
    final double dateWidth = isTablet ? 100 : 75;
    
    // Adjust item height based on screen size
    final double itemHeight = isTablet ? 70 : 60;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      height: itemHeight,
      child: Row(
        children: [
          // Date Container (Yellow)
          Container(
            width: dateWidth,
            decoration: const BoxDecoration(
              color: Color(0xFFFFD685),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                bottomLeft: Radius.circular(4),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['date']!,
                  style: TextStyle(
                    fontSize: isTablet ? 12 : 10, // Larger font for tablet
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          // Details Container (Light Green)
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFDBFFF0),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: isTablet ? 16 : 8), // More padding for tablet
                child: Row(
                  children: [
                    // Description
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Description',
                            style: TextStyle(
                              fontSize: isTablet ? 12 : 10, // Larger font for tablet
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              data['description']!,
                              style: TextStyle(
                                fontSize: isTablet ? 15: 13, // Larger font for tablet
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Quantity
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Quantity',
                            style: TextStyle(
                              fontSize: isTablet ? 12 : 10, // Larger font for tablet
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              data['quantity']!,
                              style: TextStyle(
                                fontSize: isTablet ? 15 : 13, // Larger font for tablet
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Price
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Price',
                            style: TextStyle(
                              fontSize: isTablet ? 12 : 10, // Larger font for tablet
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              data['price']!,
                              style: TextStyle(
                                fontSize: isTablet ? 15 : 13, // Larger font for tablet
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF00A81C),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Net Price
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Net Price',
                            style: TextStyle(
                              fontSize: isTablet ? 12 : 10, // Larger font for tablet
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              data['netPrice']!,
                              style: TextStyle(
                                fontSize: isTablet ? 15 : 13, // Larger font for tablet
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF00A81C),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalItem(String label, String value, Color valueColor) {
    // Get screen information
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth > 600;
    
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTablet ? 15 : 13, // Larger font for tablet
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: isTablet ? 22 : 19, // Larger font for tablet
            fontWeight: FontWeight.w900,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  final List<Map<String, String>> _salesData = [
    {
      'date': '12/07/2024',
      'description': 'Glass',
      'quantity': '12',
      'price': '\$6.00',
      'netPrice': '\$72.00',
    },
    {
      'date': '12/07/2024',
      'description': 'Mug',
      'quantity': '08',
      'price': '\$12.50',
      'netPrice': '\$100.00',
    },
    {
      'date': '12/07/2024',
      'description': 'Plate',
      'quantity': '24',
      'price': '\$8.75',
      'netPrice': '\$210.00',
    },
    {
      'date': '12/07/2024',
      'description': 'Bowl',
      'quantity': '16',
      'price': '\$9.25',
      'netPrice': '\$148.00',
    },
    {
      'date': '12/07/2024',
      'description': 'Cutlery',
      'quantity': '32',
      'price': '\$4.50',
      'netPrice': '\$144.00',
    },
    {
      'date': '12/07/2024',
      'description': 'Vase',
      'quantity': '04',
      'price': '\$42.00',
      'netPrice': '\$168.00',
    },
    {
      'date': '12/07/2024',
      'description': 'Teapot',
      'quantity': '06',
      'price': '\$35.00',
      'netPrice': '\$210.00',
    },
    {
      'date': '12/07/2024',
      'description': 'Chair',
      'quantity': '10',
      'price': '\$125.00',
      'netPrice': '\$250.00',
    },
    {
      'date': '12/07/2024',
      'description': 'Table',
      'quantity': '05',
      'price': '\$349.00',
      'netPrice': '\$745.00',
    },
    {
      'date': '12/07/2024',
      'description': 'Lamp',
      'quantity': '08',
      'price': '\$89.00',
      'netPrice': '\$712.00',
    },
    {
      'date': '12/07/2024',
      'description': 'Sofa',
      'quantity': '02',
      'price': '\$99.00',
      'netPrice': '\$798.00',
    },
    {
      'date': '12/07/2024',
      'description': 'Cabinet',
      'quantity': '03',
      'price': '\$50.00',
      'netPrice': '\$250.00',
    },
    {
      'date': '12/07/2024',
      'description': 'Rug',
      'quantity': '05',
      'price': '\$99.00',
      'netPrice': '\$495.00',
    },
    {
      'date': '12/07/2024',
      'description': 'Mirror',
      'quantity': '06',
      'price': '\$75.00',
      'netPrice': '\$150.00',
    },
    {
      'date': '12/07/2024',
      'description': 'Bookcase',
      'quantity': '04',
      'price': '\$45.00',
      'netPrice': '\$700.00',
    },
    {
      'date': '12/07/2024',
      'description': 'Clock',
      'quantity': '12',
      'price': '\$45.00',
      'netPrice': '\$540.00',
    },
    {
      'date': '12/07/2024',
      'description': 'Planter',
      'quantity': '15',
      'price': '\$22.00',
      'netPrice': '\$330.00',
    },
    {
      'date': '12/07/2024',
      'description': 'Canvas',
      'quantity': '08',
      'price': '\$65.00',
      'netPrice': '\$520.00',
    },
    {
      'date': '12/07/2024',
      'description': 'Pillow',
      'quantity': '20',
      'price': '\$28.00',
      'netPrice': '\$560.00',
    },
    {
      'date': '12/07/2024',
      'description': 'Blanket',
      'quantity': '12',
      'price': '\$85.00',
      'netPrice': '\$120.00',
    },
    {
      'date': '12/07/2024',
      'description': 'Curtain Hall',
      'quantity': '08',
      'price': '\$95.00',
      'netPrice': '\$760.00',
    },
    {
      'date': '12/07/2024',
      'description': 'Candle',
      'quantity': '35',
      'price': '\$12.50',
      'netPrice': '\$437.50',
    },
    {
      'date': '12/07/2024',
      'description': 'Basket',
      'quantity': '14',
      'price': '\$29.00',
      'netPrice': '\$406.00',
    },
    {
      'date': '12/07/2024',
      'description': 'Tray',
      'quantity': '10',
      'price': '\$45.00',
      'netPrice': '\$450.00',
    },
    {
      'date': '12/07/2024',
      'description': 'Pot',
      'quantity': '18',
      'price': '\$38.00',
      'netPrice': '\$684.00',
    },
    {
      'date': '12/07/2024',
      'description': 'Towel',
      'quantity': '24',
      'price': '\$18.50',
      'netPrice': '\$444.00',
    },
    {
      'date': '04/27/2025',
      'description': 'Bedding',
      'quantity': '06',
      'price': '\$15.00',
      'netPrice': '\$750.00',
    },
    {
      'date': '08/21/2025',
      'description': 'Diwan Bed',
      'quantity': '01',
      'price': '\$65.00',
      'netPrice': '\$625.00',
    },
    {
      'date': '09/28/2025',
      'description': 'Blender',
      'quantity': '03',
      'price': '\$95.00',
      'netPrice': '\$285.00',
    },
    {
      'date': '01/23/2025',
      'description': 'Toaster',
      'quantity': '05',
      'price': '\$65.00',
      'netPrice': '\$325.00',
    },
  ];
}