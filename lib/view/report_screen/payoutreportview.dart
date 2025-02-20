import 'package:antiquewebemquiry/date_range.dart';
import 'package:antiquewebemquiry/view/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:antiquewebemquiry/viewmodel/payoutreportviewmodel.dart';

class PayoutReportPage extends StatelessWidget {
  const PayoutReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PayoutReportViewModel(),
      child: const PayoutReportView(),
    );
  }
}

class PayoutReportView extends StatefulWidget {
  const PayoutReportView({super.key});

  @override
  State<PayoutReportView> createState() => _PayoutReportViewState();
}

class _PayoutReportViewState extends State<PayoutReportView> {

  @override
  void initState() {
    super.initState();
  }

  void _navigateToHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<PayoutReportViewModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF1EDE8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Payout Report',
          style: TextStyle(
            fontFamily: 'DM Sans',
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined, color: Colors.black),
                onPressed: () {},
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: const Center(
                    child: Text(
                      '1',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
            color: const Color(0xFFF1EDE8),
            child: DateRangePickerWidget(
              onDateRangeSelected: (DateTimeRange range) {
                setState(() {
                });
              },
              onSearch: () {
                // Implement search functionality
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMarketPayableCard(),
                    const SizedBox(height: 20),
                    _buildMarketReceivableCard(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildMarketPayableCard() {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Market Payable',
                  style: TextStyle(
                    fontFamily: 'DM Sans',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF172B4D),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Auto Deduct Rent : ',
                      style: TextStyle(
                        fontFamily: 'DM Sans',
                        fontSize: 14,
                        color: Color(0xFF172B4D),
                        fontWeight: FontWeight.normal
                      ),
                    ),
                    Text(
                      'YES',
                      style: TextStyle(
                        fontFamily: 'DM Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF00CF9D),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildPayableRow('Retail Sales', '\$253.50'),
            _buildPayableRow('Wholesales', '\$21.00'),
            _buildPayableRow('Online Sales', '\$0.00'),
            _buildPayableRow('Layaway Sales', '\$0.00'),
            _buildPayableRow('Sales Tax', '\$0.00'),
            const Divider(height: 24),
            _buildPayableRow('Total', '\$274.50', isBold: true),
            const Divider(height: 24),
            const Text(
              'Less',
              style: TextStyle(
                fontFamily: 'DM Sans',
                fontSize: 14,
                color: Color(0xFF172B4D),
              ),
            ),
            const SizedBox(height: 8),
            _buildPayableRow('Sales Returns', '\$0.00'),
            _buildPayableRow('Voids', '\$0.00'),
            const Divider(height: 24),
            _buildPayableRow('Total', '\$274.50', isBold: true),
          ],
        ),
      ),
    );
  }

  Widget _buildMarketReceivableCard() {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Market Receivable',
              style: TextStyle(
                fontFamily: 'DM Sans',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF172B4D),
              ),
            ),
            const SizedBox(height: 16),
            _buildPayableRow('Flat Commission%', '7.00'),
            _buildPayableRow('Commission on Sales', '\$19.22'),
            _buildPayableRow('Consignment Commission', '\$0.00'),
            _buildPayableRow('Credit/Debit Card Charges', '\$0.00'),
            _buildPayableRow('Adjustments(if any)', '\$0.00'),
            const Divider(height: 24),
            _buildPayableRow('Total', '\$19.22', isBold: true),
            const Divider(height: 24),
            _buildPayableRow('Rental Dues', '\$105.60'),
            const Divider(height: 24),
            _buildPayableRow('Total Due', '\$124.82', isBold: true),
            const Divider(height: 24),
            _buildAutoDetect('Total Sales - Total Dues', '\$149.68', isBold: true),
            const Divider(height: 24),
            
          ],
        ),
      ),
    );
  }

  Widget _buildPayableRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'DM Sans',
              fontSize: 14,
              color: const Color(0xFF172B4D),
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'DM Sans',
              fontSize: 14,
              color: const Color(0xFF172B4D),
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAutoDetect(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'DM Sans',
              fontSize: 14,
              color: const Color(0xFFFF8500),
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'DM Sans',
              fontSize: 14,
              color: const Color(0xFFFF8500),
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => _navigateToHome(context),
            child: _buildBottomNavItem(
              imagePath: 'assets/home.svg',
              label: 'Home',
              isSelected: false,
            ),
          ),
          _buildBottomNavItem(
            imagePath: 'assets/report.svg',
            label: 'Reports',
            isSelected: true,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem({
    required String imagePath,
    required String label,
    required bool isSelected,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          imagePath,
          width: 40,
          height: 40,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'DM Sans',
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: const Color(0xFFFF8500),
          ),
        ),
      ],
    );
  }
}