import 'package:dio/dio.dart';
import 'package:rekalaba_test_interview/model/queue_model.dart';

class QueueRepository {
  final Dio dio;

  QueueRepository() : dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
  )) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print('Requesting: ${options.method} ${options.path}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print('Response received Data');
        return handler.next(response);
      },
      onError: (DioError error, handler) {
        print('Error occurred: ${error.message}');
        return handler.next(error);
      },
    ));
  }

  Future<List<Queue>> fetchQueues() async {
    try {
      final response = await dio.get('https://api.rekalaba.com/public/transaction/queue/stores/16880?phone-number=');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['queueHistory'];
        return Queue.fromJsonList(data);
      } else {
        throw Exception('Failed to load queues');
      }
    } catch (e) {
      throw Exception('Error fetching queues: $e');
    }
  }

  Future<String> addQueue(String customerName, String? customerPhone, int pax) async {
    final response = await dio.post(
      'https://api.rekalaba.com/public/transaction/queue',
      data: {
        'storeId': 16880,
        'customerName': customerName,
        'customerPhone': customerPhone,
        'pax': pax,
      },
    );

    if (response.statusCode == 200) {
      return response.data['message'];
    } else {
      throw Exception('Gagal membuat antrian');
    }
  }

  Future<List<Queue>> fetchSuccessQueues(String phoneNumber) async {
    try {
      final response = await dio.get(
          'https://api.rekalaba.com/public/transaction/queue/stores/16880?',
          queryParameters: {
            'phone-number' : phoneNumber,
            'limit' : '1'
          }
      );
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['queueHistory'];
        return Queue.fromJsonList(data);
      } else {
        throw Exception('Failed to load queues');
      }
    } catch (e) {
      throw Exception('Error fetching queues: $e');
    }
  }
}
