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
  final DateFormat dateFormat = DateFormat('MM-dd-yyyy');

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    switch (widget.filterType) {
      case 'Daily':
        startDate = now;
        endDate = now;
        break;
      case 'Monthly':
        startDate = DateTime(now.year, now.month, 1);
        endDate = DateTime(now.year, now.month + 1, 0);
        break;
      case 'Yearly':
        startDate = DateTime(now.year, 1, 1);
        endDate = DateTime(now.year, 12, 31);
        break;
    }
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? startDate ?? DateTime.now() : endDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFFF9800),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFFF9800),
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

  String getTotalQty() {
    int total = _salesData.fold(0, (sum, item) => sum + int.parse(item['qty']!));
    return total.toString();
  }

  String getTotalPrice() {
    double total = _salesData.fold(0.0, (sum, item) {
      String priceStr = item['price']!.replaceAll('\$', '').replaceAll(',', '');
      return sum + double.parse(priceStr);
    });
    return '\$${NumberFormat('#,##0').format(total)}';
  }

  String getTotalNetPrice() {
    double total = _salesData.fold(0.0, (sum, item) {
      String netPriceStr = item['netPrice']!.replaceAll('\$', '').replaceAll(',', '');
      return sum + double.parse(netPriceStr);
    });
    return '\$${NumberFormat('#,##0').format(total)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1EDE8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'View Report',
          style: TextStyle(
            color: Color(0xFF2D3142),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black, size: 24),
            onPressed: widget.onClose,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Date Selection
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectDate(context, true),
                    child: _buildDateField(startDate, 'Start Date'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectDate(context, false),
                    child: _buildDateField(endDate, 'End Date'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Sales Report Container
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        '${widget.filterType} Sales',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF11AB86),
                        ),
                      ),
                    ),
                    // Fixed Table Header
                    Table(
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      columnWidths: const {
                        0: FlexColumnWidth(1.2),  // Date
                        1: FlexColumnWidth(0.8),  // Desc
                        2: FlexColumnWidth(0.5),  // Qty
                        3: FlexColumnWidth(0.8),  // Price
                        4: FlexColumnWidth(0.8),  // Net Price
                      },
                      children: [
                        TableRow(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Color(0xFFE5E5E5), width: 1),
                            ),
                          ),
                          children: [
                            _buildTableHeader('         Date'),
                            _buildTableHeader('  Desc'),
                            _buildTableHeader('  Qty'),
                            _buildTableHeader('     Price'),
                            _buildTableHeader('Net Price'),
                          ],
                        ),
                      ],
                    ),
                    // Scrollable Table Content
                    Expanded(
                      child: SingleChildScrollView(
                        child: Table(
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          columnWidths: const {
                            0: FlexColumnWidth(1.2),  // Date
                            1: FlexColumnWidth(0.8),  // Desc
                            2: FlexColumnWidth(0.5),  // Qty
                            3: FlexColumnWidth(0.8),  // Price
                            4: FlexColumnWidth(0.8),  // Net Price
                          },
                          children: _salesData.map((item) => _buildTableRow(item)).toList(),
                        ),
                      ),
                    ),
                    // New Totals Container
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF5F5F5),
                        border: Border(
                          top: BorderSide(color: Color(0xFFE5E5E5), width: 1),
                        ),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildTotalItem('Total Quantity', getTotalQty()),
                          _buildTotalItem('Total Price', getTotalPrice()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalItem(String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFF172B4D),
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(height: 4),
      Align(
        alignment: Alignment.center,
        child: Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF172B4D),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}


  Widget _buildDateField(DateTime? date, String placeholder) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFFE5E5E5)),
      ),
      child: Row(
        children: [
          const Icon(Icons.calendar_today, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              date != null ? dateFormat.format(date) : placeholder,
              style: const TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 2),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Color(0xFF172B4D),
        ),
      ),
    );
  }

  TableRow _buildTableRow(Map<String, String> data) {
    return TableRow(
      children: [
        _buildTableCell(data['date']!),
        _buildTableCell(data['desc']!),
        _buildTableCell(data['qty']!),
        _buildTableCell(data['price']!, alignRight: true),
        _buildTableCell(data['netPrice']!, alignRight: true),
      ],
    );
  }

  Widget _buildTableCell(String text, {bool alignRight = false, bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Text(
        text,
        textAlign: alignRight ? TextAlign.right : TextAlign.left,
        style: TextStyle(
          fontSize: 15,
          color: const Color(0xFF2D3142),
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  final List<Map<String, String>> _salesData = [
    {'date': '11-15-2023', 'desc': 'Cap', 'qty': '50', 'price': '\$16,110', 'netPrice': '\$16,110'},
    {'date': '11-20-2023', 'desc': 'Mat', 'qty': '10', 'price': '\$368', 'netPrice': '\$368'},
    {'date': '11-22-2023', 'desc': 'Pot', 'qty': '0', 'price': '\$0', 'netPrice': '\$0'},
    {'date': '11-26-2023', 'desc': 'Pen', 'qty': '8', 'price': '\$325', 'netPrice': '\$325'},
    {'date': '11-29-2023', 'desc': 'Doll', 'qty': '0', 'price': '\$0', 'netPrice': '\$0'},
    {'date': '11-30-2023', 'desc': 'Glass', 'qty': '2', 'price': '\$6', 'netPrice': '\$6'},

  ];
}