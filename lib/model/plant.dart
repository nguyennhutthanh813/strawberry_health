import 'package:cloud_firestore/cloud_firestore.dart';

class Plant {
  String imageUrl;
  DateTime date;
  Map<String, dynamic>? diseases;

  Plant({
    required this.imageUrl,
    required this.date,
    required this.diseases,
  });

  factory Plant.fromFireStore(Map<String, dynamic> fireStore) {
    return Plant(
      imageUrl: fireStore['imageUrl'] ?? '',
      date: (fireStore['date'] as Timestamp).toDate(),
      diseases: fireStore['diseases'] != null
          ? Map<String, dynamic>.from(fireStore['diseases'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'date': Timestamp.fromDate(date),
      'diseases': diseases,
    };
  }
}
