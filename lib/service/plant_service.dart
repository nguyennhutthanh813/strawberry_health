import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:strawberry_disease_detection/model/plant.dart';

class PlantService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  static final PlantService _instance = PlantService._internal();
  PlantService._internal();
  factory PlantService() {
    return _instance;
  }

  Future<List<Plant>> getAllPlants() async {
    User? user = _auth.currentUser;
    if (user == null) return [];

    QuerySnapshot snapshot = await _fireStore
        .collection('users')
        .doc(user.uid)
        .collection('plants')
        .get();

    return snapshot.docs.map((doc) => Plant.fromFireStore(doc.data() as Map<String, dynamic>)).toList();
  }
}