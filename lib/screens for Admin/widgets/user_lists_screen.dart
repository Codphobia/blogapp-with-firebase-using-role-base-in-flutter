

 import 'package:blogapp/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({Key? key}) : super(key: key);

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('profileInfo').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(!snapshot.hasData)
          {
            return Center(child: CircularProgressIndicator(),);
          }else
            {
             return ListView.builder(
                 itemCount: snapshot.data!.docs.length,
                 itemBuilder: (context,index)
                 {
                   UserModel   userModel=UserModel.fromMap(snapshot.data!.docs[index]);
                   return Card(child: ListTile(
                     leading:  Container(
                       width: 50,
                       height: 50,
                       decoration:  BoxDecoration(
                         borderRadius: BorderRadius.circular(50),
                         image: DecorationImage(
                           image: NetworkImage(
                               'https://previews.123rf.com/images/apoev/apoev1903/'
                                   'apoev190300009/124806570-%E7%81%B0%E8%89%B2%E3%81%AE%'
                                   'E8%83%8C%E6%99%AF%E3%81%ABt%E3%82%B7%E3%83%A3%E3%83%84%'
                                   'E3%82%92%E7%9D%80%E3%81%9F%E4%BA%BA%E7%81%B0%E8%89%B2%E3'
                                   '%81%AE%E5%86%99%E7%9C%9F%E3%83%97%E3%83%AC%E3%83%BC%E3%8'
                                   '2%B9%E3%83%9B%E3%83%AB%E3%83%80%E3%83%BC%E3%83%9E%E3%83%B3.jpg'),
                           fit: BoxFit.cover,
                         ),
                       ),
                     ),
                     title: Text( userModel.name ),
                     subtitle: Text( userModel.email ),
                     trailing: Text(userModel.role),

                   ),);
                 }
             );
            }
      },)
    );
  }
}

