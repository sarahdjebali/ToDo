
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel{

   String? docID;
   final String titleTask;
   final String description;
   final String Category;
   final String dateTask;
   final String timeTask;
   final bool isDone;

   TodoModel({
     this.docID,
     required this.titleTask,
     required this.description,
     required this.Category,
     required this.dateTask,
     required this.timeTask,
     required this.isDone,
   });

   Map<String, dynamic> toMap(){
     return <String, dynamic>{
       'titleTask': titleTask,
       'description': description,
       'Category': Category,
       'dateTask': dateTask,
       'timeTask': timeTask,
       'isDone' : isDone,

     };
   }

   factory TodoModel.fromMap(Map<String, dynamic> map){
     return TodoModel(
       docID: map ['docID'] != null ? map ['docID'] as String : null ,
       titleTask: map['titleTask'] as String,
       description: map['description'] as String,
       Category: map['Category'] as String,
       dateTask: map['dateTask'] as String,
       timeTask: map['timeTask'] as String,
       isDone: map['isDone'] as bool,



     );
   }

   factory TodoModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc){
   return TodoModel(
     docID: doc.id,
       titleTask: doc['titleTask'],
       description: doc['description'],
       Category: doc['Category'],
       dateTask: doc['dateTask'],
       timeTask: doc['timeTask'],
       isDone: doc['isDone']);

   }


}