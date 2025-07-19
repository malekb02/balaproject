import 'package:cloud_firestore/cloud_firestore.dart';

class RemarqueProfModel {

  final String id;
  final String prof;
  final String eleve;
  final String classe;
   String remarque;
   String remarqueSoulouk;
   DateTime timestamp;


  RemarqueProfModel( {
    required this.id,
    required  this.prof,
    required  this.remarque,
    required  this.eleve,
    required  this.classe,
    required  this.remarqueSoulouk,
    required  this.timestamp,
  });
  static RemarqueProfModel empty() => RemarqueProfModel(id: "", prof: "", remarque: "", eleve: "", classe: "",remarqueSoulouk: "", timestamp: DateTime(2000));

  Map<String, dynamic> toJson() {
    return {
      'prof': prof,
      'remarque': remarque,
      'eleve': eleve,
      'class': classe,
      'remarqueSoulouk': remarqueSoulouk,
      "timestamp": timestamp
    };
  }

  factory RemarqueProfModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return RemarqueProfModel(
      id: snapshot.id,
      prof: data['prof'] ,
      remarque: data['remarque'] ,
      eleve: data['eleve'] ,
      classe: data['class'] ,
      remarqueSoulouk: data['remarqueSoulouk'],
      timestamp: data['timestamp'].toDate() ,

    );
  }
}
