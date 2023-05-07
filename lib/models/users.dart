// import 'package:cloud_firestore/cloud_firestore.dart';

// class Users {
//   String name;
//   String email;
//   String password;

// factory Users.fromDocument(DocumentSnapshot doc) {
//    return Users.fromDocument(
     
//       amount: doc.data().toString().contains('amount') ? doc.get('amount') : 0,//Number
//       enable: doc.data().toString().contains('enable') ? doc.get('enable') : false,//Boolean
//       tags: doc.data().toString().contains('tags') ? doc.get('tags').entries.map((e) => TagModel(name: e.key, value: e.value)).toList() : [],//List<dynamic>
//    );
// }

// }
