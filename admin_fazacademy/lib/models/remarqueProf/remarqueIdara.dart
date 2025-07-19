import 'package:cloud_firestore/cloud_firestore.dart';

class RemarqueIdaraModel {

  final String id;
  final String eleve;
  final String classe;
  final String remarque;
  final DateTime timing;


  RemarqueIdaraModel( {
    required this.id,
    required  this.remarque,
    required  this.eleve,
    required  this.classe,
    required  this.timing,
  });
  static RemarqueIdaraModel empty() => RemarqueIdaraModel(id: "", remarque: "", eleve: "", classe: "",timing: DateTime.now());
  Map<String, dynamic> toJson() {
    return {
      'remarque': remarque,
      'eleve': eleve,
      'class': classe,
      'timing': timing,
    };
  }

  factory RemarqueIdaraModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return RemarqueIdaraModel(
      id: snapshot.id,
      remarque: data['remarque'] ,
      eleve: data['eleve'] ,
      classe: data['class'] ,
      timing: data['timing'].toDate(),

    );
  }
}
