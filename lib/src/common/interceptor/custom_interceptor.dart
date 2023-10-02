import 'package:dio/dio.dart';

class CustomInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['X-Naver-Client-Id'] = '';
    options.headers['X-Naver-Client-Secret'] = '';
    super.onRequest(options, handler);
  }
}
