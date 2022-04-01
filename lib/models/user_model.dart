

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel
{
  String id;
  String name;
  String email;
  String userId;
  String role;

  UserModel({required this.id,required
  this.name,required
  this.email,required this.userId,required this.role});
  factory UserModel.fromMap(DocumentSnapshot snapshot)
  {
    return UserModel(id: snapshot.id,
        name: snapshot['name'],
        email: snapshot['email'],
        userId: snapshot['uid'],
        role: snapshot['role']);
  }
}