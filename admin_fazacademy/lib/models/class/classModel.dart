import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ClassModel {

   String id;
  final List<String> listeleve;
  final String profID;
  final DateTime dateTime;
   bool pointed;
   double heure;
  final String service;

  ClassModel({
    required this.id,
    required this.listeleve,
    required this.profID,
    required this.dateTime,
    required this.pointed,
    required this.heure,
    required this.service,
  });
   ClassModel copyWith({
     String? id,
     List<String>? listeleve,
     String? profID,
     DateTime? dateTime,
     bool? pointed,
     double? heure, // Make sure this is double
     String? service,
   }) {
     return ClassModel(
       id: id ?? this.id,
       listeleve: listeleve ?? this.listeleve,
       profID: profID ?? this.profID,
       dateTime: dateTime ?? this.dateTime,
       pointed: pointed ?? this.pointed,
       heure: (heure ?? this.heure).toDouble(), // 👈 Ensure it's double
       service: service ?? this.service,
     );
   }


   static ClassModel empty() => ClassModel(id: "id", listeleve: [], profID: "profID", dateTime: DateTime(2024), pointed: false, heure: 0, service: "service");
  Map<String, dynamic> toJson() {
    return {
      'listeleve': listeleve,
      'prof': profID,
      'dateTime': dateTime,
      'pointée': pointed,
      'heure': heure,
      'service': service,
    };
  }
  factory ClassModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return ClassModel(
        id: snapshot.id,
        listeleve: List<String>.from(data['listeleve']) ?? [],
        profID: data['prof'] ?? '',
        dateTime: data['dateTime'].toDate(),
        pointed: data['pointée'] ,
        heure: double.parse(data['heure'].toString()) ,
        service: data['service'] ,
    );
  }
}
