

import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel
{
  String title;
  String description;
  String url;
  String id;

 Timestamp date;

  PostModel({required this.title,required
  this.description,required
  this.url,required this.id,required
  this.date});
  factory PostModel.fromMap(DocumentSnapshot snapshot)
  {
    return PostModel(
      id:snapshot.id,
        title: snapshot['title'],
        description:  snapshot['description'],
        url: snapshot['url'],
       date: snapshot['date'],
        );
  }
}