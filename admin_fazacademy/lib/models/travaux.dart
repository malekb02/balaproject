import 'package:cloud_firestore/cloud_firestore.dart';

class TravauxModel {
  final String id;
  final String prof ;
  final String titre ;
  final String desc ;
   bool done ;

  TravauxModel({
    required this.id,
    required this.prof,
    required this.titre,
    required this.desc,
    required this.done,
  });

  Map<String, dynamic> toJson() {
    return {
      'prof': prof,
      'titre' : titre,
      'desc' : desc,
      'done' : done,
    };
  }

  factory TravauxModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return TravauxModel(
      id: snapshot.id,
      prof: data['prof'] ?? '',
      titre: data['titre'],
      desc: data['desc'],
      done: data['done'],
    );
  }
}
