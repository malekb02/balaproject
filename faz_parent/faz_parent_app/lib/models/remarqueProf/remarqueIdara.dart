import 'package:cloud_firestore/cloud_firestore.dart';

class RemarqueIdaraModel {

  final String id;
  final String eleve;
  final String classe;
  final String remarque;


  RemarqueIdaraModel( {
    required this.id,
    required  this.remarque,
    required  this.eleve,
    required  this.classe,
  });
  static RemarqueIdaraModel empty() => RemarqueIdaraModel(id: "", remarque: "", eleve: "", classe: "");
  Map<String, dynamic> toJson() {
    return {
      'remarque': remarque,
      'eleve': remarque,
      'class': remarque,
    };
  }

  factory RemarqueIdaraModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return RemarqueIdaraModel(
      id: snapshot.id,
      remarque: data['remarque'] ,
      eleve: data['eleve'] ,
      classe: data['class'] ,

    );
  }
}
