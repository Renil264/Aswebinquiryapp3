
import 'package:antiquewebemquiry/view/report_screen/payoutreportview.dart';
import 'package:antiquewebemquiry/view/report_screen/salesreportview.dart';
import 'package:flutter/material.dart';

class ReportsViewModel extends ChangeNotifier {
  void navigateToReport(BuildContext context, String route) {
    switch (route) {
      case '/payout-report':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PayoutReportPage()),
        );
        break;
      case '/sales-report':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SalesReportPage()),
        );
        break;
    }
  }
}