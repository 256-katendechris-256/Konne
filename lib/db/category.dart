import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class Category{

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref ='categories';
  void createCategory(String name) async{
    var id =Uuid();
    //String categoryId = id.v1();
   try{
     await _firestore.collection('categories').doc().set({'categoryName': name});
   }catch(e){
     print('Error creating category: $e');
   }
  }
  Future<List<DocumentSnapshot>> getCategory(){
    return _firestore.collection('categories').get().then((snaps){
      return snaps.docs;
    });

  }
  Future<List<Map<String, dynamic>>> getSuggestions(String suggestion) async {
    print('Querying for suggestion: $suggestion');
    final QuerySnapshot<Map<String, dynamic>> snap = await _firestore
        .collection('categories')
        .where('category', isEqualTo: suggestion)
        .get();

    print('Query result: ${snap.docs}');
    return snap.docs.map((DocumentSnapshot<Map<String, dynamic>> doc) => doc.data()!).toList();
  }


/*
  Future<List<Map<String, dynamic>>> getSuggestions(String suggestion) async {
    final QuerySnapshot<Map<String, dynamic>> snap = await _firestore
        .collection('categories')
        .where('category', arrayContains: suggestion)
        .get();

    return snap.docs
        .map((DocumentSnapshot<Map<String, dynamic>> doc) => doc.data()!).toList();
  }
  */

}