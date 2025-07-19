import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceModel {
  String niveau;
  final String id;
  final String nom ;
  final String type ;

  ServiceModel({
    required this.nom,
    required this.type,
    required this.id,
    required this.niveau,
  });

  Map<String, dynamic> toJson() {
    return {
      'niveau': niveau,
      'nom' : nom,
      'type' : type,
    };
  }

  factory ServiceModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return ServiceModel(
        id: snapshot.id,
        niveau: data['niveau'] ?? '',
        nom: data['nom'],
        type: data['type'],
    );
  }
}
