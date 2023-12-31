import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class serviceHandler{
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref ='services';
  void uploadService({
    required String serviceName,
    required String description,
    required String category,
    required int price,
    required List<String> imageUrls,
  }){
    var id = Uuid();
    String serviceId = id.v1();

    _firestore.collection(ref).doc(serviceId).set({
      'serviceName': serviceName,
      'description': description,
      'category': category,
      'price': price,
      'imageUrls': imageUrls,
    });
  }
}