import 'dart:convert';

import 'package:flutter_app_pos/data/datasources/auth_local_datasource.dart';
import 'package:flutter_app_pos/data/models/response/qris_response_model.dart';
import 'package:flutter_app_pos/data/models/response/qris_status_response_model.dart';
import 'package:http/http.dart' as http;

class MidtransRemoteDatasource {
  String generateBasicAuthHeader(String serverKey) {
    final base64Credentials =
        base64Encode(utf8.encode('Mid-server-giBlJYoB9TfWiEc5nmqI161n'));
    final authHeader = 'Basic $base64Credentials';

    return authHeader;
  }

  Future<QrisResponseModel> generateQRCode(
      String orderId, int grossAmount) async {
    final serverKey = await AuthLocalDatasource().getMitransServerKey();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization':
          generateBasicAuthHeader('Mid-server-giBlJYoB9TfWiEc5nmqI161n'),
    };

    final body = jsonEncode({
      'payment_type': 'gopay',
      'transaction_details': {
        'gross_amount': grossAmount,
        'order_id': orderId,
      },
    });

    final response = await http.post(
      Uri.parse('https://api.midtrans.com/v2/charge'),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return QrisResponseModel.fromJson(response.body);
    } else {
      throw Exception('Failed to generate QR Code');
    }
  }

  Future<QrisStatusResponseModel> checkPaymentStatus(String orderId) async {
    final serverKey = await AuthLocalDatasource().getMitransServerKey();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization':
          generateBasicAuthHeader('Mid-server-giBlJYoB9TfWiEc5nmqI161n'),
    };

    final response = await http.get(
      Uri.parse('https://api.midtrans.com/v2/$orderId/status'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return QrisStatusResponseModel.fromJson(response.body);
    } else {
      throw Exception('Failed to check payment status');
    }
  }
}
