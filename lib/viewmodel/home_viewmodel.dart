import 'package:flutter/material.dart';
import '../model/sales_model.dart';

class HomeViewModel extends ChangeNotifier {
  SalesModel _salesData = SalesModel(totalItemsSold: 135, totalSalesAmount: 345.97);
  Function(BuildContext)? _navigationCallback;

  SalesModel get salesData => _salesData;

  // Initialize navigation callback
  void initNavigation(Function(BuildContext) callback) {
    _navigationCallback = callback;
  }

  // Navigate to reports
  void navigateToReports(BuildContext context) {
    _navigationCallback?.call(context);
  }

  void updateSalesData(int itemsSold, double amount) {
    _salesData = SalesModel(totalItemsSold: itemsSold, totalSalesAmount: amount);
    notifyListeners();
  }
}
