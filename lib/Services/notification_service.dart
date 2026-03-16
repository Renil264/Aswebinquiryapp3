import 'package:antiquewebemquiry/model/notification_model.dart';
import 'package:dio/dio.dart';


class NotificationService {
  final Dio _dio = Dio();

  Future<List<SalesNotification>> fetchSalesNotifications({
    required String location,
    required int VendorId,
  })async {
    final response = await _dio.get('http://192.168.144/Anitiquesoft/Home/newSaleAndNotify', queryParameters: {
      'location' : location,
      'vendorId' : VendorId,
    }

    );

    final List sales = response.data['sales'];

    return sales.map((json) => SalesNotification.fromJson(json)).toList();
      
  }
}