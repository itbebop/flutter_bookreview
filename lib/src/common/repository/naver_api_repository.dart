import 'package:bookreview/src/common/model/naver_book_info_results.dart';
import 'package:bookreview/src/common/model/naver_book_search_option.dart';
import 'package:dio/dio.dart';

class NaverBookRepository {
  // 의존성 주입 (확장성을 고려)
  // naver의 다른 api를 사용할 수 있기 때문에
  final Dio _dio;
  NaverBookRepository(this._dio);
  // 아래와 같이 직접 header 세팅해도 되지만, 확장성 고려하여 interceptor로 처리
  // void test() {
  //   _dio.get('path', options: Options(headers: ));
  //  }

  Future<NaverBookInfoResults> searchBooks(
      NaverBookSearchOption searchOption) async {
    var response = await _dio.get('v1/search/book.json',
        queryParameters: searchOption.toMap());
    //print(response);
    //return true;
    return NaverBookInfoResults.fromJson(response.data);
  }
}
