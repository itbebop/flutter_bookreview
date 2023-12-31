import 'package:bookreview/src/common/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  FirebaseFirestore db;
  UserRepository(this.db);

  Future<UserModel?> findUserOne(String uid) async {
    try {
      var doc = await db.collection('users').where('uid', isEqualTo: uid).get(); // users라는 테이블을 만들어줄 것. uid값이 같으면 doc를 전달
      if (doc.docs.isEmpty) {
        return null;
      } else {
        return UserModel.fromJson(doc.docs.first.data()); //
      }
    } catch (e) {
      return null;
    }
  }
}
