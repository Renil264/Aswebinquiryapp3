import 'package:antiquewebemquiry/model/payoutreportmodel.dart';
import 'package:flutter/foundation.dart';
// ignore: implementation_imports
import 'package:flutter/src/material/date.dart';


class PayoutReportViewModel extends ChangeNotifier {
  final PayoutReportModel _model = PayoutReportModel();

  PayoutReportModel get model => _model;

  get dateRange => null;

  void refreshData() {
    // Implement refresh logic here
    notifyListeners();
  }

  void updateDateRange(DateTimeRange picked, DateTime end) {}
}