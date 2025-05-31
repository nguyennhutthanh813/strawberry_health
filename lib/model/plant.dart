import 'package:cloud_firestore/cloud_firestore.dart';

class Plant {
  String imageUrl;
  DateTime date;

  Plant({
    required this.imageUrl,
    required this.date,
  });

  factory Plant.fromFireStore(Map<String, dynamic> fireStore) {
    return Plant(
      imageUrl: fireStore['imageUrl'] ?? '',
      date: (fireStore['date'] as Timestamp).toDate(),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'date': Timestamp.fromDate(date),
    };
  }
}
