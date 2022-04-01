import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseManager {
  final CollectionReference profileData =
      FirebaseFirestore.instance.collection('profileInfo');
  final CollectionReference post =
      FirebaseFirestore.instance.collection('postsList');


  Future<void> createUserData(String name, String role, String uid, String email) async {
    return await profileData.doc(uid).set({
      'uid': uid,
      'name': name,
      'role': role,
      'email':email,
    });
  }

  Future  createPost(String title, String description, String url, ) async {
    return await post.add({

      'title':title,
      'description':description,
      'url':url,
      'date':DateTime.now(),

    });
  }
  Future  updatePost(String title, String description, String url,id ) async {
    return await post.doc(id).update({
      'title':title,
      'description':description,
      'url':url,
      'date':DateTime.now(),
    });
  }
  Future deletePost(String id)async{
    await post.doc(id).delete();
  }





 // we can use these function instead of streambuilder
  // Future getUserList() async {
  //   List itemList = [];
  //   try {
  //     await profileData.get().then((querySnapshot) {
  //       querySnapshot.docs.forEach((element) {
  //         itemList.add(element.data());
  //       });
  //     });
  //     return itemList;
  //   } catch (e) {
  //     return null;
  //   }
  // }

  // Future getPostList() async {
  //   List itemList = [];
  //   try {
  //     await post.get().then((querySnapshot) {
  //       querySnapshot.docs.forEach((element) {
  //         itemList.add(element.data());
  //       });
  //     });
  //     return itemList;
  //   } catch (e) {
  //     return null;
  //   }
  // }
}
