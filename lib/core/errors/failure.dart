import 'package:dio/dio.dart';

class Failure {
  final String message;

  Failure(this.message);

  factory Failure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return Failure('انتهت مهلة الاتصال بالخادم');
      case DioExceptionType.sendTimeout:
        return Failure('انتهت مهلة إرسال البيانات');
      case DioExceptionType.receiveTimeout:
        return Failure('انتهت مهلة استقبال البيانات');
      case DioExceptionType.badResponse:
        return Failure._fromResponse(dioError.response?.statusCode, dioError.response?.data);
      case DioExceptionType.cancel:
        return Failure('تم إلغاء الطلب');
      case DioExceptionType.connectionError:
        return Failure('لا يوجد اتصال بالإنترنت');
      case DioExceptionType.unknown:
        if (dioError.message?.contains('SocketException') ?? false) {
          return Failure('لا يوجد اتصال بالإنترنت');
        }
        return Failure('حدث خطأ غير متوقع، يرجى المحاولة لاحقاً');
      default:
        return Failure('حدث خطأ ما، يرجى المحاولة لاحقاً');
    }
  }

  factory Failure._fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return Failure(response['message'] ?? 'طلب غير صالح');
    } else if (statusCode == 404) {
      return Failure('العنصر غير موجود');
    } else if (statusCode == 500) {
      return Failure('خطأ في الخادم الداخلي، يرجى المحاولة لاحقاً');
    } else {
      return Failure('حدث خطأ ما، يرجى المحاولة لاحقاً');
    }
  }
}
