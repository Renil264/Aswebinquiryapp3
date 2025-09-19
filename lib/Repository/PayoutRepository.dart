import 'dart:convert';
import 'package:antiquewebemquiry/Constants/baseurl.dart';
import 'package:antiquewebemquiry/Global/location.dart';
import 'package:antiquewebemquiry/Global/vendorid.dart';
import 'package:antiquewebemquiry/model/payoutmodel.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class PayoutReportRepository {
  final String baseUrl = "$baseurl/Home/getPayoutSummary";

  Future<PayoutReportModel> fetchPayoutSummary({
    required String location,
    required int vendorID,
    required DateTime fromDate,
    required DateTime toDate,
  }) async {
    final dateFormat = DateFormat("yyyy-MM-dd");

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "location": location,
          "vendorID": vendorID,
          "fromDate": dateFormat.format(fromDate),
          "toDate": dateFormat.format(toDate),
        }),
      );

      if (response.statusCode == 200) {
        final jsonBody = jsonDecode(response.body);

        // ✅ If API says "data not found", return empty object
        if (jsonBody == null || (jsonBody['status'] == 'data not found')) {
          return PayoutReportModel.empty();
        }

        return PayoutReportModel.fromJson(jsonBody);
      } else {
        print("Fetch error: ${response.body}");
        return PayoutReportModel.empty();
      }
    } catch (e) {
      print("Exception in fetchPayoutSummary: $e");
      return PayoutReportModel.empty();
    }
  }
}
